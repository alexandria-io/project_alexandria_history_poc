# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140612200102) do

  create_table "archives", :force => true do |t|
    t.string   "archive_term"
    t.string   "archive_type"
    t.string   "archive_title"
    t.string   "florincoin_address"
    t.decimal  "florincoin_price"
    t.boolean  "creating_archive",   :default => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "librarians", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pages", :force => true do |t|
    t.integer  "volume_id"
    t.string   "page_title"
    t.text     "page_text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "records", :force => true do |t|
    t.integer  "archive_id"
    t.integer  "favorite_count"
    t.string   "filter_level"
    t.string   "in_reply_to_screen_name"
    t.string   "in_reply_to_attrs_id"
    t.string   "in_reply_to_status_id"
    t.string   "in_reply_to_user_id"
    t.string   "lang"
    t.integer  "retweet_count"
    t.string   "source"
    t.text     "tweet_text"
    t.datetime "created_date"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "torrents", :force => true do |t|
    t.integer  "archive_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "volumes", :force => true do |t|
    t.integer  "archive_id"
    t.string   "volume_title"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
