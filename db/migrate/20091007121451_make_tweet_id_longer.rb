class MakeTweetIdLonger < ActiveRecord::Migration
  def self.up
    change_column :tweets, :twitter_identifier, "bigint"
    # this forces tweets with an overflowed id to re-download
    execute("delete from tweets where twitter_identifier = 2147483647")
  end

  def self.down
    change_column :tweets, :twitter_identifier, :integer
  end
end
