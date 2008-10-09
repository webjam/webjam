require "rexml/document"
require "open-uri"
require "cgi"

class ViddlerVideo < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event
  belongs_to :jam
  
  named_scope :featured, :conditions => {:featured => true}
  
  API_BASE = "http://api.viddler.com/rest/v1/"
  
  # Loads new images not in DB
  def self.fetch_new(event)
    ids_to_add = viddler_ids_on_viddler(event) - viddler_ids_in_db(event)
    ids_to_add.each {|id| create_or_update_video(event, id)}
  end
  
  # Updates existing images with tags/assocs etc.
  def self.update_existing(event)
    viddler_ids_in_db(event).each {|id| create_or_update_video(event, id)}
  end
  
  private
  
  def self.viddler_ids_in_db(event)
    ids = Array.new
    event.viddler_videos.each {|vid| ids << vid.identifier}
    ids
  end
  
  def self.viddler_ids_on_viddler(event)
    ids = Array.new
    page = 1
    while load_page_of_ids_from_viddler(event, ids, page)
      page += 1
    end
    ids
  end
  
  def self.load_page_of_ids_from_viddler(event, ids, page)
    counter = 0
    response = request("viddler.videos.getByTag",{"tag" => [event.tag], "per_page" => 100, "page" => page})
    photo_ids = REXML::XPath.match(response, "//video_list/video").collect do |elem|
      counter += 1
      ids << elem.elements['id'].get_text.to_s
    end
    counter == 100 ? true : false
  end
  
  # grabs a page of videos and stores them. if there are more pages, returns true.
  def self.create_or_update_video(event, viddlerid)
    vv = ViddlerVideo.find_by_identifier(viddlerid)
    unless vv
      vv = ViddlerVideo.new
      vv.identifier = viddlerid
    end

    response = request("viddler.videos.getDetails",{"video_id" => viddlerid, "add_embed_code" => 1})

    vv.username = REXML::XPath.match(response, "//video/author")[0].get_text.to_s
    vv.title = REXML::XPath.match(response, "//video/title")[0].get_text.to_s
    vv.description = REXML::XPath.match(response, "//video/description")[0].get_text.to_s
    vv.posted_at = Time.at(REXML::XPath.match(response, "//video/upload_time")[0].get_text.to_s.to_i/1000)
    vv.video_url = REXML::XPath.match(response, "//video/url")[0].get_text.to_s
    vv.thumbnail_url = REXML::XPath.match(response, "//video/thumbnail_url")[0].get_text.to_s
    vv.length_in_seconds = REXML::XPath.match(response, "//video/length_seconds")[0].get_text.to_s.to_i
    vv.object_html = REXML::Text::unnormalize(REXML::XPath.match(response, "//video/embed_code")[0].get_text.to_s)
    vv.event_id = event.id
    
    # the next section needs some regex love. In fact, it is common with viddler
    # so should be cleaned up and turned into a module or mixin or something.
    REXML::XPath.match(response, "//video/tags/global").each do |tagelem|
      tag = tagelem.get_text.to_s.downcase
      if tag.split(':')[0] == event.tag.downcase && tag.split(':')[1]
        # this is one of the webjam8 tags
        vv.featured = true if tag.split(':')[1].downcase == "videos=featured"
        if tag.split(':')[1].downcase.index("presentation=")
          presid = tag.split(':')[1].downcase.split("=")[1].to_i
          if jam = Jam.find_by_number(presid)
            vv.jam = jam
          end
        end
      elsif tag.split(':')[0] == "webjam" && tag.split(':')[1]
        # this is one of the generic tags
        if tag.split(':')[1].downcase.index("peep=")
          peep = tag.split(':')[1].downcase.split("=")[1]
          if user = User.find_by_nick_name(peep)
            vv.users << user
          end
        end
      end
    end

    vv.save
  end
  
  # method for performing a request
  def self.request(method, arguments={})
    arg_map = arguments.collect {|arg,value| CGI.escape(arg)+"="+CGI.escape(value.to_s)}.join("&")
    call_uri = "#{API_BASE}?api_key=#{APPLICATION_CONFIG.viddler_api_key}&method=#{method}&#{arg_map}"
    response = REXML::Document.new(open(call_uri).read)
    return response
  end
  
end
