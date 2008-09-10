class AddAddressToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :address, :text, :default => ""
  end

  def self.down
    remove_column :events, :address
  end
end
