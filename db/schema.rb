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

ActiveRecord::Schema.define(:version => 20120607123839) do

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.text     "comment"
    t.integer  "rating"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "specials", :force => true do |t|
    t.integer  "venue_id"
    t.string   "name"
    t.text     "description"
    t.datetime "special_starts_at"
    t.datetime "special_finishes_at"
    t.boolean  "available_monday"
    t.boolean  "available_tuesday"
    t.boolean  "available_wednesday"
    t.boolean  "available_thursday"
    t.boolean  "available_friday"
    t.boolean  "available_saturday"
    t.boolean  "available_sunday"
    t.datetime "end_date"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "trading_times", :force => true do |t|
    t.integer  "venue_id"
    t.datetime "monday_opens_at"
    t.datetime "monday_closes_at"
    t.datetime "tuesday_opens_at"
    t.datetime "tuesday_closes_at"
    t.datetime "wednesday_opens_at"
    t.datetime "wednesday_closes_at"
    t.datetime "thursday_opens_at"
    t.datetime "thursday_closes_at"
    t.datetime "friday_opens_at"
    t.datetime "friday_closes_at"
    t.datetime "saturday_opens_at"
    t.datetime "saturday_closes_at"
    t.datetime "sunday_opens_at"
    t.datetime "sunday_closes_at"
  end

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
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "name"
    t.boolean  "oauth",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "street_address"
    t.integer  "postcode"
    t.string   "suburb"
    t.string   "url"
    t.string   "email"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "phone_number"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "slug"
  end

  add_index "venues", ["slug"], :name => "index_venues_on_slug", :unique => true

end
