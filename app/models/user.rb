class User < ActiveRecord::Base
  has_one :mugshot, :dependent => :destroy
  has_many :temporary_mugshots, :class_name => 'Mugshot', :foreign_key => 'temp_user_id'
  has_many :posts # TODO: DEPENDENT?
  has_many :identity_urls, :dependent => :destroy
  has_many :rsvps
  has_many :events, :through => :rsvps
  
  validates_presence_of :full_name, :nick_name, :email
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :nick_name

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
  
  def openid_sreg_fields=(fields)
    fields && fields.each_pair do |key,val|
      self[attr_for_openid_sreg_field(key)] = val
    end
  end
  
  def website_display_name
    if !website_name.blank?
      website_name
    else
      website_url.sub('http://', '')
    end
  end
  
  def to_param
    nick_name
  end
  
  def to_s
    nick_name
  end

  def rsvp_for(event)
    rsvps.detect {|rsvp| rsvp.event == event}
  end
  alias_method :rsvped?, :rsvp_for
  
  def proposal_for(event)
    proposals.detect {|prop| prop.event == event}
  end
  alias_method :proposed_for?, :proposal_for
  
  protected
    def attr_for_openid_sreg_field(field)
      {
        "nickname" => "nick_name",
        "email"    => "email",
        "fullname" => "full_name"
      }[field]
    end
end
