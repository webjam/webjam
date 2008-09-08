require "rexml/document"
require "open-uri"
require "cgi"

class FlickrPhoto < ActiveRecord::Base
  
  has_one :event
  
  named_scope :featured, :conditions => {:featured => true}

  ## Build a URL
  def url
    "http://farm#{farm}.static.flickr.com/#{server}/#{flickrid}_#{secret}.jpg"
  end
  
  def self.fetch(event)
    posted_before = Time.at(0) # default to beginning of time, aka. 1970
    latest_photo = event.flickr_photos.find(:first, :order => "posted_before DESC")
    if latest_photo
      posted_before = latest_photo.posted_before
    end
    arguments = Hash.new
    arguments["tags"] = [event.tag]
    arguments["min_upload_date"] = posted_before.to_i + 1
    arguments["sort"] = "date-posted-asc"
    retrieve(event, arguments)
  end

  private
  
  ## search on flickr and add to db.
  def self.retrieve(event, arguments={})
    logger.info("FlickrPhoto::retrieve About to start retrieve")
    response = request("flickr.photos.search",arguments)
    # we need to grab the last looked up photo and get it's load date.
    lastphoto = REXML::XPath.match(response, "//photo[last()]")
    unless lastphoto[0]
      # no images retrieved, do nothing
      logger.info("FlickrPhoto::retrieve No images found for event #{event.name}")
      return
    end
    lastphotoid = lastphoto[0].attributes['id']
    # we will use this latest load date to set the loaded before in the db,
    # to determine where to start the next load.
    latest_load_date = posted_date_for_image(lastphotoid)
    # now stash them in DB.
    photo_ids = REXML::XPath.match(response, "//photo").collect do |photoelem|
      id = photoelem.attributes['id'].to_i
      fp = FlickrPhoto.new
      fp.flickrid = id
      fp.server = photoelem.attributes['server']
      fp.farm = photoelem.attributes['farm']
      fp.secret = photoelem.attributes['secret']
      fp.title = photoelem.attributes['title']
      fp.owner = photoelem.attributes['owner']
      fp.posted_before = latest_load_date
      fp.event_id = event.id
      logger.info("FlickrPhoto::retrieve About to save image #{fp.title} (flickr id: #{fp.flickrid}) for event #{event.name}")
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
  
  ## this method gets info about a certain photo
  def self.posted_date_for_image(id)
    response = request("flickr.photos.getInfo", "photo_id" => id.to_s)
    # why can't I make //photo/dates@posted work?
    Time.at(REXML::XPath.match(response, "//photo/dates@posted")[0].attributes["posted"].to_i)
  end
  
end
