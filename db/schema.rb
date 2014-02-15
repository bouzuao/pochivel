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

ActiveRecord::Schema.define(version: 20140215095008) do

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.integer  "choice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hotels", force: true do |t|
    t.string   "planname"
    t.string   "roomname"
    t.string   "plandetailurl"
    t.string   "facility"
    t.string   "plancheckin"
    t.string   "plancheckOut"
    t.string   "splyperiodstrday"
    t.string   "splyperiodendday"
    t.string   "planpictureurl"
    t.string   "planpicturecaption"
    t.string   "meal"
    t.string   "ratetype"
    t.string   "samplerate"
    t.string   "servicechargerate"
    t.string   "stay"
    t.string   "date"
    t.string   "month"
    t.string   "year"
    t.string   "rate"
    t.string   "stock"
    t.string   "hotelid"
    t.string   "hotelname"
    t.string   "postcode"
    t.string   "hoteladdress"
    t.string   "region"
    t.string   "prefecture"
    t.string   "largearea"
    t.string   "smallarea"
    t.string   "hoteltype"
    t.string   "hoteldetailurl"
    t.string   "hotelcatchcopy"
    t.string   "hotelcaption"
    t.string   "pictureurl"
    t.string   "picturecaption"
    t.string   "x"
    t.string   "y"
    t.string   "hotelnamekana"
    t.string   "numberofratings"
    t.string   "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "tel"
    t.integer  "number"
    t.integer  "date"
    t.integer  "span"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
