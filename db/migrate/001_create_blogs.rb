class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :body, :text
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
      t.column :published_at, :timestamp
    end
  end

  def self.down
    drop_table :blogs
  end
end
