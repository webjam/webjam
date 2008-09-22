class ChangeMapUrlsToText < ActiveRecord::Migration
  def self.up
    change_column :events, :map_url, :text
    change_column :events, :map_iframe_url, :text
  end

  def self.down
    change_column :events, :map_url, :string
    change_column :events, :map_iframe_url, :string
  end
end
