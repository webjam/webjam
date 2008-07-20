class AddHypeToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :hype, :text
  end

  def self.down
    remove_column :events, :hype
  end
end
