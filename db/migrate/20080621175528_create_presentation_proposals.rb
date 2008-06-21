class CreatePresentationProposals < ActiveRecord::Migration
  def self.up
    create_table :presentation_proposals do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :presentation_proposals
  end
end
