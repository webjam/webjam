class RemoveNumberOfPresentersFromJams < ActiveRecord::Migration
  def self.up
    remove_column :jams, :number_of_presenters
  end

  def self.down
    add_column :jams, :number_of_presenters, :integer,     :limit => 11
  end
end
