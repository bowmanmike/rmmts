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

ActiveRecord::Schema.define(version: 20160228193242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chores", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "due_date"
    t.integer  "frequency"
    t.boolean  "complete"
    t.integer  "house_id"
    t.integer  "mate_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "chores", ["house_id"], name: "index_chores_on_house_id", using: :btree
  add_index "chores", ["mate_id"], name: "index_chores_on_mate_id", using: :btree

  create_table "expenses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "due_date"
    t.float    "amount"
    t.integer  "house_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "expenses", ["house_id"], name: "index_expenses_on_house_id", using: :btree

  create_table "houses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
  end

  add_index "houses", ["creator_id"], name: "index_houses_on_creator_id", using: :btree

  create_table "mates", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "house_id"
  end

  add_index "mates", ["email"], name: "index_mates_on_email", unique: true, using: :btree

  create_table "payments", force: :cascade do |t|
    t.float    "amount"
    t.datetime "paid_date"
    t.integer  "mate_id"
    t.integer  "expense_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "payments", ["expense_id"], name: "index_payments_on_expense_id", using: :btree
  add_index "payments", ["mate_id"], name: "index_payments_on_mate_id", using: :btree

  add_foreign_key "chores", "houses"
  add_foreign_key "chores", "mates"
  add_foreign_key "expenses", "houses"
  add_foreign_key "payments", "expenses"
  add_foreign_key "payments", "mates"
end
