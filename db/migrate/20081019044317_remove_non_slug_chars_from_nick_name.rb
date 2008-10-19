class RemoveNonSlugCharsFromNickName < ActiveRecord::Migration
  class User < ActiveRecord::Base; end
  
  def self.up
    User.all.each do |user|
      user.update_attribute(:nick_name, user.nick_name.gsub(/[^a-zA-Z0-9_-]/,''))
    end
  end

  def self.down
  end
end
