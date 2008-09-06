class MultipleUsersPerJam < ActiveRecord::Migration
  def self.up
    add_column :jams, :number_of_presenters, :integer
    remove_column :jams, :user_id
    create_table "jams_users", :id => false do |t|
      t.column "jam_id", :integer, :null => false
      t.column "user_id",  :integer, :null => false
    end
    
  end

  def self.down
    remove_column :jams, :number_of_presenters
    add_column :jams, :user_id, :integer
    drop_table :jams_users
  end
end
