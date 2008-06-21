class DropEvents < ActiveRecord::Migration
  def self.up
    drop_table :events
  end

  def self.down
    create_table "events", :force => true do |t|
      t.datetime "held_at"
      t.datetime "published_at"
      t.text     "description"
      t.integer  "location_id",  :limit => 11
    end
    
  end
end
