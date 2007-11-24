class CreateJams < ActiveRecord::Migration
  def self.up
    create_table :jams do |t|
      t.column :event_id, :integer
      t.column :title, :string
    end
  end

  def self.down
    drop_table :jams
  end
end
