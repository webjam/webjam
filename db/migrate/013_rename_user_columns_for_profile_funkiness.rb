class RenameUserColumnsForProfileFunkiness < ActiveRecord::Migration
  def self.up
    rename_column :users, :real_name, :name
    rename_column :users, :homepage, :website_url
    add_column :users, :website_name, :string
  end

  def self.down
    rename_column :users, :name, :real_name
    rename_column :users, :website_url, :homepage
    remove_column :users, :website_name
  end
end
