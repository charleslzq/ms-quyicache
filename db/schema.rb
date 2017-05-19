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

ActiveRecord::Schema.define(version: 20170519090950) do

  create_table "app_hospitals", force: :cascade do |t|
    t.string "hospitalId"
    t.string "hospitalName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dict_codes", force: :cascade do |t|
    t.string "typeId"
    t.string "codeId"
    t.string "codeName"
    t.string "codeStatus"
    t.string "lastUpdateUser"
    t.integer "codeSeq"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lastUpdateTime"
  end

  create_table "medicine_shops", force: :cascade do |t|
    t.string "shopId"
    t.string "shopName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
