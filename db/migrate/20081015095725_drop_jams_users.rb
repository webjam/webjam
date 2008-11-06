class DropJamsUsers < ActiveRecord::Migration
  def self.up
    drop_table :jams_users
  end

  def self.down
    create_table "jams_users", :id => false, :force => true do |t|
      t.integer "jam_id",  :limit => 11, :null => false
      t.integer "user_id", :limit => 11, :null => false
    end
    
  end
end
