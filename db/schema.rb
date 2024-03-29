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

ActiveRecord::Schema.define(:version => 20121014142330) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
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

  create_table "releasers", :force => true do |t|
    t.string   "name",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.string   "url"
  end

  add_index "releasers", ["name"], :name => "index_releasers_on_name", :unique => true

  create_table "releases", :force => true do |t|
    t.text     "raw",                            :null => false
    t.integer  "releaser_id",                    :null => false
    t.integer  "title_id",                       :null => false
    t.string   "episodes"
    t.string   "extension"
    t.string   "audio"
    t.string   "video"
    t.string   "resolution"
    t.string   "crc32"
    t.string   "volume"
    t.string   "source"
    t.string   "media"
    t.boolean  "delta",       :default => false, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "details_url"
  end

  add_index "releases", ["raw"], :name => "index_releases_on_raw", :unique => true
  add_index "releases", ["releaser_id"], :name => "index_releases_on_releaser_id"
  add_index "releases", ["title_id"], :name => "index_releases_on_title_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "title_id"
    t.integer  "releaser_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "subscriptions", ["releaser_id"], :name => "index_subscriptions_on_releaser_id"
  add_index "subscriptions", ["title_id"], :name => "index_subscriptions_on_title_id"
  add_index "subscriptions", ["user_id", "title_id", "releaser_id"], :name => "index_subscriptions_on_user_id_and_title_id_and_releaser_id", :unique => true
  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "titles", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "titles", ["name"], :name => "index_titles_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  :default => false, :null => false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
