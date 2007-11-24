class CreateIdentityUrls < ActiveRecord::Migration
  def self.up
    create_table :identity_urls do |t|
      t.column :user_id, :integer
      t.column :url, :text
    end
  end

  def self.down
    drop_table :identity_urls
  end
end
