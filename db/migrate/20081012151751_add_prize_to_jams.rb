class AddPrizeToJams < ActiveRecord::Migration
  def self.up
    add_column :jams, :prize, :string
  end

  def self.down
    remove_column :jams, :prize
  end
end
