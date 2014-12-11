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

ActiveRecord::Schema.define(version: 20141211213156) do

  create_table "cover_photos", force: true do |t|
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "listings", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.decimal  "amount",                precision: 9, scale: 8
    t.string   "address"
    t.string   "token"
    t.string   "key"
    t.integer  "sales",                                         default: 0
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.integer  "listing_id"
    t.boolean  "captured",                           default: false, null: false
    t.boolean  "withdrawn",                          default: false, null: false
    t.decimal  "amount",     precision: 9, scale: 8
    t.string   "label"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
