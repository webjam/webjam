class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :body
      t.string :username
      t.integer :twitter_identifier
      t.integer :event_id
      t.datetime :posted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
