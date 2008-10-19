require 'uri'

class User < ActiveRecord::Base
  # From http://www.igvita.com/2006/09/07/validating-url-in-ruby-on-rails/
  URI_FORMAT = /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  NICK_NAME_FORMAT = /\A[a-zA-Z0-9_\-]+\Z/
  
  has_many :posts # TODO: DEPENDENT?
  has_many :identity_urls, :dependent => :destroy
  has_many :rsvps
  has_many :events, :through => :rsvps
  has_many :presentation_proposals
  has_and_belongs_to_many :jams
  has_and_belongs_to_many :flickr_photos
  has_and_belongs_to_many :viddler_videos
  
  validates_presence_of :full_name, :email
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :nick_name
  validates_format_of :website_url, :with => URI_FORMAT, :allow_nil => true
  validates_format_of :nick_name, :with => NICK_NAME_FORMAT, :allow_nil => true, :message => "can only contain the characters a-z, A-Z, 0-9, - and _"
  validates_length_of :nick_name, :in => (2..20)
  
  has_attached_file :mugshot,
                    :styles => { 
                                 :large  => '140x140>',
                                 :medium => '82x82>',
                                 :small  => '50x50>',
                                 :tiny   => '25x25>'
                               },
                      :default_url => "/images/default_avatar_:style.gif",
                      :whiny_thumbnails => true

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
  def openid_sreg_fields=(sreg_response)
    sreg_response && sreg_response.data.each_pair do |key,val|
      self[self.class.attr_for_openid_sreg_field(key)] = val
    end
  end
  
  def website_display_name
    if !website_name.blank?
      website_name
    else
      website_url.sub('http://', '')
    end
  end
  
  def website_url=(new_website_url)
    new_website_url = "http://#{new_website_url}" if new_website_url !~ /^https?:\/\//
    write_attribute(:website_url, new_website_url)
  end
  
  def to_param
    nick_name
  end
  
  def to_s
    nick_name
  end
  
  def to_recipient
    %("#{self.full_name}" <#{self.email}>)
  end

  def rsvp_for(event)
    rsvps.detect {|rsvp| rsvp.event == event}
  end
  alias_method :rsvped?, :rsvp_for
  
  def proposal_for(event)
    presentation_proposals.detect {|prop| prop.event == event}
  end
  alias_method :proposed_for?, :proposal_for
  
  def self.attr_for_openid_sreg_field(field)
    {
      "nickname" => "nick_name",
      "email"    => "email",
      "fullname" => "full_name"
    }[field]
  end
  
  def validate_website_url
    if self.website_url.strip.not.blank? && self.website_url !~ URI.regexp(['http', 'https'])
      self.errors.add(:website_url, "is not valid")
    end
  end
end
