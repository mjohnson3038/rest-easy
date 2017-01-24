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

ActiveRecord::Schema.define(version: 20170123223125) do

  create_table "guest_items", force: :cascade do |t|
    t.integer  "list_item_id"
    t.integer  "meal_percentage"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "price"
    t.integer  "guest_id"
    t.index ["list_item_id"], name: "index_guest_items_on_list_item_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "receipt_id"
    t.decimal  "tip"
    t.decimal  "item_total"
    t.index ["receipt_id"], name: "index_guests_on_receipt_id"
  end

  create_table "list_items", force: :cascade do |t|
    t.integer  "receipt_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "quantity"
    t.float    "price"
    t.index ["receipt_id"], name: "index_list_items_on_receipt_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.string   "name"
    t.string   "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "zip_code"
    t.integer  "status"
    t.decimal  "tax"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
