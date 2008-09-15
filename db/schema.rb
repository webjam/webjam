# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080914052910) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id",          :limit => 11
    t.integer  "commentable_id",   :limit => 11
    t.string   "commentable_type"
    t.text     "body"
    t.datetime "created_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "tag"
    t.datetime "held_at"
    t.string   "timezone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rsvp_limit",               :limit => 11
    t.datetime "published_at"
    t.string   "location"
    t.text     "hype"
    t.datetime "proposals_close_at"
    t.string   "map_iframe_url"
    t.string   "map_url"
    t.string   "campaign_monitor_list_id"
    t.text     "address"
  end

  create_table "flickr_photos", :force => true do |t|
    t.string   "flickrid"
    t.string   "server"
    t.string   "farm"
    t.string   "secret"
    t.string   "title"
    t.string   "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id",           :limit => 11
    t.datetime "posted_before"
    t.boolean  "featured",                         :default => false
    t.string   "username"
    t.datetime "posted_at"
    t.datetime "taken_at"
    t.string   "url"
    t.integer  "license_identifier", :limit => 11
    t.string   "license_text"
    t.string   "realname"
    t.string   "profile_url"
  end

  create_table "identity_urls", :force => true do |t|
    t.integer "user_id", :limit => 11
    t.text    "url"
  end

  create_table "jams", :force => true do |t|
    t.integer  "event_id",                 :limit => 11
    t.integer  "presentation_proposal_id", :limit => 11
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_presenters",     :limit => 11
  end

  create_table "jams_users", :id => false, :force => true do |t|
    t.integer "jam_id",  :limit => 11, :null => false
    t.integer "user_id", :limit => 11, :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mugshots", :force => true do |t|
    t.integer  "temp_user_id", :limit => 11
    t.integer  "user_id",      :limit => 11
    t.integer  "parent_id",    :limit => 11
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size",         :limit => 11
    t.integer  "width",        :limit => 11
    t.integer  "height",       :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.binary  "server_url"
    t.string  "handle"
    t.binary  "secret"
    t.integer "issued",     :limit => 11
    t.integer "lifetime",   :limit => 11
    t.string  "assoc_type"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :limit => 11,                 :null => false
    t.string  "server_url"
    t.string  "salt",                     :default => "", :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id",      :limit => 11
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.string   "permalink"
    t.integer  "year",         :limit => 11
    t.integer  "event_id",     :limit => 11
  end

  create_table "presentation_proposals", :force => true do |t|
    t.integer  "user_id",     :limit => 11
    t.integer  "event_id",    :limit => 11
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rsvps", :force => true do |t|
    t.integer  "event_id",   :limit => 11
    t.integer  "user_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rsvps", ["event_id", "user_id"], :name => "index_rsvps_on_event_id_and_user_id", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tweets", :force => true do |t|
    t.string   "body"
    t.string   "username"
    t.integer  "twitter_identifier", :limit => 11
    t.integer  "event_id",           :limit => 11
    t.datetime "posted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "nick_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "full_name"
    t.text     "website_url"
    t.string   "website_name"
    t.string   "permalink"
    t.boolean  "admin",                                   :default => false, :null => false
    t.string   "mugshot_file_name"
    t.string   "mugshot_content_type"
    t.integer  "mugshot_file_size",         :limit => 11
  end

  create_table "viddler_videos", :force => true do |t|
    t.integer  "identifier",        :limit => 11
    t.string   "title"
    t.string   "username"
    t.string   "description"
    t.integer  "length_in_seconds", :limit => 11
    t.string   "video_url"
    t.string   "thumbnail_url"
    t.text     "object_html"
    t.integer  "event_id",          :limit => 11
    t.datetime "posted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
