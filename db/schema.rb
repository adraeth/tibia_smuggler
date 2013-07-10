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

ActiveRecord::Schema.define(:version => 20130705135837) do

  create_table "assignments", :force => true do |t|
    t.integer "user_id"
    t.integer "permission_id"
  end

  add_index "assignments", ["permission_id"], :name => "index_assignments_on_permission_id"
  add_index "assignments", ["user_id", "permission_id"], :name => "index_assignments_on_user_id_and_permission_id", :unique => true
  add_index "assignments", ["user_id"], :name => "index_assignments_on_user_id"

  create_table "login_attempts", :force => true do |t|
    t.string   "ip"
    t.string   "login"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news", :force => true do |t|
    t.datetime "date_to_show"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "order_statuses", :force => true do |t|
    t.string "text"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "order_status_id",  :null => false
    t.integer  "world_from_id",    :null => false
    t.integer  "world_to_id",      :null => false
    t.integer  "amount_from"
    t.integer  "amount_to"
    t.string   "character_from"
    t.string   "character_to"
    t.string   "ip"
    t.string   "rejection_reason"
    t.datetime "accepted_at"
    t.datetime "received_at"
    t.datetime "completed_at"
    t.datetime "rejected_at"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "orders", ["order_status_id"], :name => "index_orders_on_order_status_id"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"
  add_index "orders", ["world_from_id"], :name => "index_orders_on_world_from_id"
  add_index "orders", ["world_to_id"], :name => "index_orders_on_world_to_id"

  create_table "permissions", :force => true do |t|
    t.string "name"
  end

  add_index "permissions", ["name"], :name => "index_permissions_on_name", :unique => true

  create_table "rates", :force => true do |t|
    t.integer "from_world_type_id"
    t.integer "to_world_type_id"
    t.decimal "rate"
    t.boolean "reducible",          :default => false, :null => false
    t.decimal "reduction_step",     :default => 0.0,   :null => false
  end

  add_index "rates", ["from_world_type_id", "to_world_type_id"], :name => "index_rates_on_from_world_type_id_and_to_world_type_id", :unique => true
  add_index "rates", ["from_world_type_id"], :name => "index_rates_on_from_world_type_id"
  add_index "rates", ["to_world_type_id"], :name => "index_rates_on_to_world_type_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "signup_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["signup_ip"], :name => "index_users_on_signup_ip"

  create_table "world_types", :force => true do |t|
    t.string "name"
  end

  add_index "world_types", ["name"], :name => "index_world_types_on_name", :unique => true

  create_table "worlds", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "account"
    t.boolean  "blocked_for_incoming"
    t.boolean  "blocked_for_outgoing"
    t.integer  "amount"
    t.decimal  "rate"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "world_type_id"
  end

  add_index "worlds", ["name"], :name => "index_worlds_on_name", :unique => true
  add_index "worlds", ["world_type_id"], :name => "index_worlds_on_world_type_id"

end
