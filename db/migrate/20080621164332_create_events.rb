class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.string :tag
      t.datetime :held_at
      t.string :timezone

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
