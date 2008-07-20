class AddProposalsCloseAtToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :proposals_close_at, :datetime
  end

  def self.down
    remove_column :events, :proposals_close_at
  end
end
