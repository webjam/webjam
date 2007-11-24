class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.column :title, :string
      t.column :held_on, :date
    end
  end

  def self.down
    drop_table :events
  end
end
