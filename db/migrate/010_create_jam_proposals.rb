class CreateJamProposals < ActiveRecord::Migration
  def self.up
    create_table :jam_proposals do |t|
      t.column :user_id, :integer
      t.column :title, :text
      t.column :description, :text
    end
  end

  def self.down
    drop_table :jam_proposals
  end
end
