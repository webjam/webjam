class CreatePresenters < ActiveRecord::Migration
  def self.up
    create_table :presenters, :force => true do |t|
      t.integer :user_id
      t.integer :jam_id
      t.string :name
      t.string :url
      t.timestamps
    end
  end

  def self.down
    drop_table :presenters
  end
end
