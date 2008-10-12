class AddPlaceToJams < ActiveRecord::Migration
  def self.up
    add_column :jams, :place, :integer
  end

  def self.down
    remove_column :jams, :place
  end
end
