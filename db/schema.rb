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

ActiveRecord::Schema.define(:version => 20091115140135) do

  create_table "matches", :force => true do |t|
    t.integer  "twitter_id"
    t.text     "post_status"
    t.text     "user_status"
    t.string   "introduce_to_user"
    t.string   "introduced_by_user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bot_name"
    t.integer  "user_status_id"
  end

  create_table "raw_words", :force => true do |t|
    t.integer  "twitter_id"
    t.string   "user_name"
    t.string   "reading"
    t.string   "surface"
    t.string   "pos"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raw_words", ["pos"], :name => "index_raw_words_on_pos"
  add_index "raw_words", ["reading"], :name => "index_raw_words_on_reading"
  add_index "raw_words", ["twitter_id"], :name => "index_raw_words_on_twitter_id"
  add_index "raw_words", ["user_name"], :name => "index_raw_words_on_user_name"

  create_table "statuses", :force => true do |t|
    t.integer  "twitter_id"
    t.text     "message"
    t.integer  "to_status_id"
    t.string   "to_user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "twitter_id"
    t.string   "screen_name"
    t.string   "profile_image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "words", :force => true do |t|
    t.string   "name"
    t.integer  "count"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
