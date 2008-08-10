class AddMugshotFields < ActiveRecord::Migration
  def self.up
    drop_table :mugshots
    
    add_column :users, :mugshot_file_name   , :string
    add_column :users, :mugshot_content_type, :string
    add_column :users, :mugshot_file_size   , :integer
  end

  def self.down
    create_table(:mugshots) {|t| }
    remove_column :users, :mugshot_file_name
    remove_column :users, :mugshot_content_type
    remove_column :users, :mugshot_file_size
  end
end