class CreateJams < ActiveRecord::Migration
  def self.up
    create_table :jams do |t|
      t.belongs_to :user
      t.belongs_to :event      
      t.belongs_to :presentation_proposal
      
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :jams
  end
end
