require "rexml/document"
require "open-uri"
require "cgi"

class FlickrPhoto < ActiveRecord::Base


  def url
    "http://farm#{farm}.static.flickr.com/#{server}/#{flickrid}_#{secret}.jpg"
  end

  def self.stored_photo_ids
    ids = Array.new
    self.find(:all).each {|fp| ids << fp.flickrid }
    ids
  end

  ## this method is used to grab new images from flickr
  def self.load_from_flickr
    puts "--- LOADING IMAGES FROM FLICKR ---"
    search_by_tags(['webjam', 'lachlanhardy'])
    
    puts "--- END LOAD ---"
  end
  
  
  ## perform a search on flickr
  def self.search(arguments={})
    curr_ids = stored_photo_ids
    response = request("flickr.photos.search",arguments)
    photo_ids = REXML::XPath.match(response, "//photo").collect do |photoelem|
      id = photoelem.attributes['id'].to_i
      puts "Found image, id: #{id}"
      unless curr_ids.index(id.to_s)
        puts "Image #{id} not in the db, loading."
        fp = FlickrPhoto.new
        fp.flickrid = id
        fp.server = photoelem.attributes['server']
        fp.farm = photoelem.attributes['farm']
        fp.secret = photoelem.attributes['secret']
        fp.title = photoelem.attributes['title']
        fp.owner = photoelem.attributes['owner']
        fp.save!
      end
    end # /attribute::id   a.value
  end
  
  def self.search_by_tags(tags, arguments={})
    arguments["tags"] = tags.join(",")
    search(arguments)
  end
  
  
  
  
  private
  
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
