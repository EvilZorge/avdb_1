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

ActiveRecord::Schema.define(version: 20141205160108) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balances", force: true do |t|
    t.integer  "price"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", force: true do |t|
    t.integer "credit_id"
    t.string  "money"
  end

  create_table "credit_kinds", force: true do |t|
    t.string "name"
    t.string "max_amount"
    t.string "condition"
    t.string "rate"
    t.string "max_time"
    t.string "form_kind"
    t.string "term"
    t.string "currency"
  end

  create_table "credits", force: true do |t|
    t.integer "user_id"
    t.string  "purpose"
    t.string  "amount"
    t.string  "time"
    t.string  "state",          default: "new"
    t.integer "credit_kind_id"
  end

  create_table "currencies", force: true do |t|
    t.string   "charcode"
    t.string   "name"
    t.integer  "rate"
    t.integer  "rateToday"
    t.integer  "currency_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "legal_people", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "registration_code"
    t.string   "leader"
    t.string   "accountant_general"
    t.string   "director"
    t.string   "sub_company"
    t.string   "income"
    t.string   "phone"
    t.string   "email"
    t.string   "skype"
    t.datetime "creation_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "legal_people", ["user_id"], name: "index_legal_people_on_user_id", using: :btree

  create_table "natural_people", force: true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "middlename"
    t.string   "address"
    t.string   "passport_data"
    t.string   "phone"
    t.string   "email"
    t.string   "skype"
    t.string   "work_place"
    t.string   "function"
    t.string   "income"
    t.integer  "age"
    t.string   "marital_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "natural_people", ["user_id"], name: "index_natural_people_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "user"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
