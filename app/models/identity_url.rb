class IdentityUrl < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :url
  validates_uniqueness_of :url, :case_sensitive => false, :allow_nil => true, :message => 'belongs to an existing webjammer'
  
  before_destroy :ensure_not_the_last_identity_url
  protected
    def ensure_not_the_last_identity_url
      return false if user.identity_urls.length == 1
    end
end
