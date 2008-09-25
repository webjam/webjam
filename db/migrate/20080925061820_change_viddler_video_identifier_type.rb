class ChangeViddlerVideoIdentifierType < ActiveRecord::Migration
  def self.up
    change_column :viddler_videos, :identifier, :string
  end

  def self.down
    change_column :viddler_videos, :identifier, :integer
  end
end
