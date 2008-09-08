class AddEventsCampaignMonitorListId < ActiveRecord::Migration
  def self.up
    add_column :events, :campaign_monitor_list_id, :string
  end

  def self.down
    remove_column :events, :campaign_monitor_list_id
  end
end
