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

ActiveRecord::Schema.define(version: 20140320215007) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_food", force: true do |t|
    t.integer "category_id"
    t.integer "food_id"
  end

  add_index "categories_food", ["food_id", "category_id"], name: "index_categories_food_on_food_id_and_category_id"
  add_index "categories_food", ["food_id"], name: "index_categories_food_on_food_id"

  create_table "deliveries", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "address"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "food", force: true do |t|
    t.integer  "delivery_id"
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "food_ingredients", force: true do |t|
    t.integer "ingredient_id"
    t.integer "food_id"
  end

  add_index "food_ingredients", ["food_id", "ingredient_id"], name: "index_food_ingredients_on_food_id_and_ingredient_id"
  add_index "food_ingredients", ["food_id"], name: "index_food_ingredients_on_food_id"

  create_table "ingredients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lines", force: true do |t|
    t.integer  "food_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.text     "metadata"
    t.datetime "ordered_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

end
