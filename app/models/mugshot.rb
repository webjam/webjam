class Mugshot < ActiveRecord::Base
  belongs_to :user
  has_attachment :min_size => 100.bytes,
                 :max_size => 8048.kilobytes,
                 :resize_to => '1200x1200>',
                 :thumbnails => { :large => '200x200', :medium => '100x100', :small => '50x50', :tiny => '25x25' },
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
