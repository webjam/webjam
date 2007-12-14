class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.timestamps
    end
    add_column :events, :location_id, :integer
    remove_column :events, :city
  end

  def self.down
    add_column :events, :city, :string
    remove_column :events, :location_id
    drop_table :locations
  end
end
