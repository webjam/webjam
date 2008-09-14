class CreateViddlerVideos < ActiveRecord::Migration
  def self.up
    create_table :viddler_videos do |t|
      t.integer :identifier
      t.string :title
      t.string :username
      t.string :description
      t.integer :length_in_seconds
      t.string :video_url
      t.string :thumbnail_url
      t.text :object_html
      t.integer :event_id
      t.datetime :posted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :viddler_videos
  end
end
