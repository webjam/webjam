class AddNumberToJams < ActiveRecord::Migration
  def self.up
    add_column :jams, :number, :integer
  end

  def self.down
    remove_column :jams, :number
  end
end
