class Mugshot < ActiveRecord::Base
  belongs_to :user
  has_attachment :min_size => 100.bytes,
                 :max_size => 8048.kilobytes,
                 :resize_to => '1200x1200>',
                 :thumbnails => { :large => '140x140', :medium => '82x82', :small => '50x50', :tiny => '16x16' },
                 :processor => "ImageScience",
                 :storage => :file_system
  can_be_cropped
  validates_as_attachment
  
  before_save :unmark_temporary_user_if_user_set

  protected
    def unmark_temporary_user_if_user_set
      self.temp_user_id = nil if self.user_id
    end
end
