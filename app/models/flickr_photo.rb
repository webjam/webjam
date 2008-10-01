require "rexml/document"
require "open-uri"
require "cgi"

class FlickrPhoto < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :event
  belongs_to :jam
  
  named_scope :featured, :conditions => {:featured => true}
  named_scope :latest, lambda {|n| {:order => "created_at DESC", :limit => n} }
  named_scope :latest_5, {:order => "created_at DESC", :limit => 5}

  ## Build a URL to the image
  def img_url(size="o")
    size_path = size == "l" ? "" : "_#{size}"
    "http://farm#{farm}.static.flickr.com/#{server}/#{flickrid}_#{secret}#{size_path}.jpg"
  end
  
  def <=>(other)
    self.created_at <=> other.created_at
  end
  
  # Loads new images not in DB
  def self.fetch_new(event)
    ids_to_add = flickr_ids_on_flickr(event) - flickr_ids_in_db(event)
    license_hash = license_text_hash
    ids_to_add.each {|id| create_or_update_image(event, id, license_hash)}
  end
  
  # Updates existing images with tags/assocs etc.
  def self.update_existing(event)
    license_hash = license_text_hash
    flickr_ids_in_db(event).each {|id| create_or_update_image(event, id, license_hash)}
  end
  
  # returns a hash, keyed by the flickr licence id, containing the text
  # of the license
  def self.license_text_hash
    license_info = Hash.new
    response = request("flickr.photos.licenses.getInfo")
    REXML::XPath.match(response, "//licenses/license").each do |elem|
      license_info[elem.attributes["id"].to_i] = elem.attributes["name"]
    end
    license_info
  end
  
  # Creates or updates and image in an event for the given flickr ID.
  def self.create_or_update_image(event, flickrid, license_hash=nil)
    # load the image, or create a new one
    fp = FlickrPhoto.find_by_flickrid(flickrid)
    unless fp
      fp = FlickrPhoto.new
      fp.flickrid = flickrid
    end
    response = FlickrPhoto.request("flickr.photos.getInfo", "photo_id" => flickrid.to_s)
    
    # check the tag list for a matching event tag - if it doesn't exist, remove and return
    event_tag_found = false
    REXML::XPath.match(response, "//photo/tags/tag").each do |tagelem|
      # the match is simple - either has the event tag, or a machine tag starting with the event tag.
      event_tag_found = true if tagelem.get_text.to_s.downcase == event.tag.downcase ||
        tagelem.get_text.to_s.downcase.index(event.tag.downcase + ":")
    end
    
    # if there is no event tag, remove this image and return
    unless event_tag_found
      logger.info "Image with flickr id #{flickrid} (#{fp.url}) has no event tags - deleting"
      fp.destroy
      return
    end
    
    # if we get to here there is an event tag, so we can get and update the details.
    photoelem = REXML::XPath.match(response, "//photo")[0]
    fp.server = photoelem.attributes['server']
    fp.farm = photoelem.attributes['farm']
    fp.secret = photoelem.attributes['secret']
    fp.title = photoelem.attributes['title']
    fp.event_id = event.id
    
    fp.posted_at = Time.at(REXML::XPath.match(response, "//photo/dates")[0].attributes["posted"].to_i)
    fp.owner = REXML::XPath.match(response, "//photo/owner")[0].attributes["nsid"]
    fp.username = REXML::XPath.match(response, "//photo/owner")[0].attributes["username"]
    fp.realname = REXML::XPath.match(response, "//photo/owner")[0].attributes["realname"]
    url = ''
    REXML::XPath.match(response, "//urls/url").each do |elem|
      url = elem.get_text.to_s if elem.attributes["type"] == "photopage"
    end
    fp.url = url
    fp.license_identifier = REXML::XPath.match(response, "//photo")[0].attributes["license"].to_i
    fp.license_text = license_hash[fp.license_identifier] if license_hash
    fp.taken_at = REXML::XPath.match(response, "//photo/dates")[0].attributes["taken"]
    
    #user
    user_response = FlickrPhoto.request("flickr.people.getInfo", "user_id" => fp.owner)
    fp.profile_url = REXML::XPath.match(user_response, "//person/profileurl")[0].get_text.to_s
    
    # now we need to parse the machine tags, and set/unset associations as required.
    fp.users.clear
    fp.jam = nil
    fp.featured = false
    
    # the next section needs some regex love. In fact, it is common with viddler
    # so should be cleaned up and turned into a module or mixin or something.
    REXML::XPath.match(response, "//photo/tags/tag[@machine_tag=1]").each do |tagelem|
      tag = tagelem.get_text.to_s.downcase
      if tag.split(':')[0] == event.tag.downcase
        # this is one of the webjam8 tags
        fp.featured = true if tag.split(':')[1].downcase == "photos=featured"
        if tag.split(':')[1].downcase.index("presentation=")
          presid = tag.split(':')[1].downcase.split("=")[1].to_i
          if jam = Jam.find_by_number(presid)
            fp.jam = jam
          end
        end
      elsif tag.split(':')[0] == "webjam"
        # this is one of the generic tags
        if tag.split(':')[1].downcase.index("peep=")
          peep = tag.split(':')[1].downcase.split("=")[1]
          if user = User.find_by_nick_name(peep)
            fp.users << user
          end
        end
      end
    end

    fp.save    
  end

  def self.flickr_ids_in_db(event)
    ids = Array.new
    event.flickr_photos.each {|fp| ids << fp.flickrid}
    ids
  end
  
  def self.flickr_ids_on_flickr(event)
    ids = Array.new
    page = 1
    while load_page_of_ids_from_flickr(event, ids, page)
      page += 1
    end
    ids
  end
  
  private
  
  def self.load_page_of_ids_from_flickr(event, ids, page)
    counter = 0
    response = request("flickr.photos.search",{"tags" => [event.tag], "per_page" => 100, "page" => page})
    photo_ids = REXML::XPath.match(response, "//photo").collect do |photoelem|
      ids << photoelem.attributes['id']
      counter += 1
    end
    counter == 100 ? true : false
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
