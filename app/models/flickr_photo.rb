require "rexml/document"
require "open-uri"
require "cgi"

class FlickrPhoto < ActiveRecord::Base
  
  has_one :event

  ## Build a URL
  def url
    "http://farm#{farm}.static.flickr.com/#{server}/#{flickrid}_#{secret}.jpg"
  end
  
  ## this method gets info about a certain photo
  def self.posted_date_for_image(id)
    puts "checking posted date for image"
    response = request("flickr.photos.getInfo", "photo_id" => id.to_s)
    # why can't I make //photo/dates@posted work?
    Time.at(REXML::XPath.match(response, "//photo/dates@posted")[0].attributes["posted"].to_i)
  end
  
  def self.retrieve_by_tags_newer_than(event_id, tags, earliest_date, arguments={})
    arguments["tags"] = tags.join(",")
    arguments["min_upload_date"] = earliest_date.to_i + 1
    arguments["sort"] = "date-posted-asc"
    retrieve(event_id, arguments)
  end

  private
  
  ## search on flickr and add to db.
  def self.retrieve(event_id, arguments={})
    puts "beginning retrieve"
    response = request("flickr.photos.search",arguments)
    # we need to grab the last looked up photo and get it's load date.
    lastphoto = REXML::XPath.match(response, "//photo[last()]")
    unless lastphoto[0]
      puts "No images retrieved, stopping"
      return
    end
    lastphotoid = lastphoto[0].attributes['id']
    # we will use this latest load date to set the loaded before in the db,
    # to determine where to start the next load.
    latest_load_date = posted_date_for_image(lastphotoid)
    
    # now stash them in DB.
    photo_ids = REXML::XPath.match(response, "//photo").collect do |photoelem|
      id = photoelem.attributes['id'].to_i
      puts "Found image, id: #{id}"
      fp = FlickrPhoto.new
      fp.flickrid = id
      fp.server = photoelem.attributes['server']
      fp.farm = photoelem.attributes['farm']
      fp.secret = photoelem.attributes['secret']
      fp.title = photoelem.attributes['title']
      fp.owner = photoelem.attributes['owner']
      fp.posted_before = latest_load_date
      fp.event_id = event_id
      fp.save!
    end # /attribute::id   a.value
  end
  
  ## method for doing a request
  def self.request(method, arguments={})
    api_key = APPLICATION_CONFIG.flickr_api_key
    
    endpoint = "http://api.flickr.com/services/rest/"
    arg_map = arguments.collect {|arg,value| CGI.escape(arg)+"="+CGI.escape(value.to_s)}.join("&")
    call_uri = "#{endpoint}?api_key=#{api_key}&method=#{method}&#{arg_map}"
    response = REXML::Document.new(open(call_uri).read)
    if response.root.attributes["stat"] == "ok" then
      return response
    elsif response.root.attributes["stat"] == "fail" then
      raise "Flickr API error #{response.elements["rsp/err"].attributes["code"]}: #{response.elements["rsp/err"].attributes["msg"]}"
    else
      raise "Request status neither ok nor fail. Tried to fetch #{call_uri}."
    end
  end
  
end
