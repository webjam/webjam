require "rexml/document"
require "open-uri"
require "cgi"

class ViddlerVideo < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event
  belongs_to :jam
  
  API_BASE = "http://api.viddler.com/rest/v1/"
  # this will change.. check http://wiki.developers.viddler.com/index.php/OEMBED
  OEMBED_API_BASE = "http://lab.viddler.com/services/oembed/"
  
  def self.fetch_for_event(event)
    # because the API doesn't allow query params, we need to get a list of identifiers 
    # that are in the DB to check if we already have this video, and pull *all* videos
    # down. this is non optimal, so shoudln't be run too frequently (<5 mins?)
    identifiers = Array.new
    # todo - optimize this with a select if table is too large
    event.viddler_videos.each {|vid| identifiers << vid.identifier}
    
    page = 1
    per_page = 100
    while load_and_store_page_of_videos(event, identifiers, per_page, page)
      page += 1
    end
  end
  
  private
  
  # grabs a page of videos and stores them. if there are more pages, returns true.
  def self.load_and_store_page_of_videos(event, existing_identifiers, number_per_page, page)
    arguments = Hash.new
    arguments["tag"] = [event.tag]
    response = request("viddler.videos.getByTag",arguments)
    
    # we use this to track if there are more videos.
    counter = 0
    
    # now stash them in DB.
    photo_ids = REXML::XPath.match(response, "//video_list/video").collect do |elem|
      counter += 1
      identifier = elem.elements['id'].get_text.to_s
      unless existing_identifiers.index(identifier)
        vv = ViddlerVideo.new
        vv.identifier = identifier
        vv.username = elem.elements['author'].get_text.to_s
        vv.title = elem.elements['title'].get_text.to_s
        vv.description = elem.elements['description'].get_text.to_s
        vv.posted_at = Time.at(elem.elements['upload_time'].get_text.to_s.to_i/1000)
        vv.video_url = elem.elements['url'].get_text.to_s
        vv.thumbnail_url = elem.elements['thumbnail_url'].get_text.to_s
        vv.length_in_seconds = elem.elements['length_seconds'].get_text.to_s.to_i
        vv.event_id = event.id
        # find the embed code from the oembed API.
        oembed_call_uri = "#{OEMBED_API_BASE}?url=#{vv.video_url}&format=json"
        oembed_response = JSON.parse(open(oembed_call_uri).read)
        vv.object_html = oembed_response["html"]
        logger.info("VidlerVideo::retrieve About to save video #{vv.title} (viddler id: #{vv.identifier}) for event #{event.name}")
        vv.save!
      end
    end
    
    if counter == number_per_page
      return true # may be more videos
    else
      return false # no more videos.
    end
  end
  
  # method for performing a request
  def self.request(method, arguments={})
    arg_map = arguments.collect {|arg,value| CGI.escape(arg)+"="+CGI.escape(value.to_s)}.join("&")
    call_uri = "#{API_BASE}?api_key=#{APPLICATION_CONFIG.viddler_api_key}&method=#{method}&#{arg_map}"
    response = REXML::Document.new(open(call_uri).read)
    return response
  end
  
end
