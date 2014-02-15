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

ActiveRecord::Schema.define(version: 20140215171334) do

  create_table "api_requests", force: true do |t|
    t.string   "url"
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "tel"
    t.integer  "number"
    t.integer  "date"
    t.integer  "span"
    t.integer  "reg_id"
    t.integer  "cond_1"
    t.integer  "cond_2"
    t.integer  "cond_3"
    t.integer  "cond_4"
    t.integer  "cond_5"
    t.integer  "cond_6"
    t.integer  "cond_7"
    t.integer  "cond_8"
    t.integer  "cond_9"
    t.integer  "last_cond_1"
    t.integer  "last_cond_2"
    t.integer  "last_cond_3"
    t.integer  "last_cond_4"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
