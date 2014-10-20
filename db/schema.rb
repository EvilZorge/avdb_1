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

ActiveRecord::Schema.define(version: 20141006233152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balances", force: true do |t|
    t.integer  "price"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "phone"
    t.string   "email"
    t.string   "skype"
    t.datetime "creation_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "marital_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
