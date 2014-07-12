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

ActiveRecord::Schema.define(version: 20140712180636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "airports", force: true do |t|
    t.string   "airport_name"
    t.string   "city"
    t.string   "state"
    t.string   "faa_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "non_fuel_charges", force: true do |t|
    t.integer  "receipt_id"
    t.string   "student_name"
    t.string   "charge_type"
    t.string   "amount"
    t.string   "status",       default: "pending"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "non_fuel_charges", ["receipt_id"], name: "index_non_fuel_charges_on_receipt_id", using: :btree

  create_table "planes", force: true do |t|
    t.string   "fuel_type"
    t.string   "tail_number"
    t.string   "plane_type"
    t.string   "slug"
    t.string   "status",      default: "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "planes", ["slug"], name: "index_planes_on_slug", unique: true, using: :btree

  create_table "receipts", force: true do |t|
    t.integer  "plane_id"
    t.integer  "airport_id"
    t.date     "receipt_date"
    t.string   "receipt_number"
    t.string   "slug"
    t.string   "vendor_name"
    t.string   "status",         default: "pending"
    t.decimal  "fuel_cost"
    t.decimal  "gallons"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reimbursement"
  end

  add_index "receipts", ["airport_id"], name: "index_receipts_on_airport_id", using: :btree
  add_index "receipts", ["plane_id"], name: "index_receipts_on_plane_id", using: :btree
  add_index "receipts", ["slug"], name: "index_receipts_on_slug", unique: true, using: :btree

  create_table "reports", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "slug"
    t.date     "starts_on"
    t.date     "ends_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reports", ["slug"], name: "index_reports_on_slug", unique: true, using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

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
    t.string   "name"
    t.string   "slug"
    t.string   "anumber"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
