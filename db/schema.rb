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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140724085655) do

  create_table "bookings", force: true do |t|
    t.date     "date_submit"
    t.date     "date_expiry"
    t.date     "date_book"
    t.string   "status"
    t.integer  "user_id"
    t.integer  "time_slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bulletins", force: true do |t|
    t.string   "title",                      null: false
    t.date     "date",                       null: false
    t.text     "content",                    null: false
    t.boolean  "send_notify", default: true
    t.integer  "user_id",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "condo_images", force: true do |t|
    t.integer  "condo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "condos", force: true do |t|
    t.string   "name"
    t.string   "property_type"
    t.string   "developer"
    t.string   "tenure"
    t.string   "top_year"
    t.integer  "num_of_units"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_images", force: true do |t|
    t.text     "description"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.time     "event_start"
    t.time     "event_end"
    t.string   "location"
    t.string   "organiser"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facilities", force: true do |t|
    t.string   "name",                                   null: false
    t.float    "booking_price",                          null: false
    t.float    "deposit_price",                          null: false
    t.text     "note"
    t.string   "image_path_file_name"
    t.string   "image_path_content_type"
    t.integer  "image_path_file_size"
    t.datetime "image_path_updated_at"
    t.boolean  "active",                  default: true
    t.integer  "facility_category_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facility_categories", force: true do |t|
    t.string   "name"
    t.integer  "condo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facility_statuses", force: true do |t|
    t.integer  "facility_id"
    t.date     "close_from"
    t.date     "close_to"
    t.text     "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedback_categories", force: true do |t|
    t.string   "name"
    t.integer  "condo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedback_replies", force: true do |t|
    t.text     "content"
    t.integer  "feedback_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "archive",              default: false
    t.integer  "user_id"
    t.integer  "feedback_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form_categories", force: true do |t|
    t.string   "name",       null: false
    t.integer  "condo_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", force: true do |t|
    t.string   "title",                  null: false
    t.string   "form_path_file_name"
    t.string   "form_path_content_type"
    t.integer  "form_path_file_size"
    t.datetime "form_path_updated_at"
    t.integer  "form_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "functions", force: true do |t|
    t.string   "alias"
    t.integer  "permission_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guard_house_images", force: true do |t|
    t.string   "name"
    t.string   "image_path_file_name"
    t.string   "image_path_content_type"
    t.integer  "image_path_file_size"
    t.datetime "image_path_updated_at"
    t.integer  "guard_house_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guard_houses", force: true do |t|
    t.string   "phone"
    t.string   "photo_path_file_name"
    t.string   "photo_path_content_type"
    t.integer  "photo_path_file_size"
    t.datetime "photo_path_updated_at"
    t.string   "map_path_file_name"
    t.string   "map_path_content_type"
    t.integer  "map_path_file_size"
    t.datetime "map_path_updated_at"
    t.integer  "condo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "house_rules", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "condo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "join_events", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "per_roles", force: true do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permissions", force: true do |t|
    t.string   "per_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "role_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_slots", force: true do |t|
    t.integer  "facility_id"
    t.time     "slot_start"
    t.time     "slot_end"
    t.boolean  "peak"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "name"
    t.string   "phone"
    t.string   "company"
    t.string   "postal_code"
    t.text     "enquiry"
    t.string   "country"
    t.string   "city"
    t.integer  "condo_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "active"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
