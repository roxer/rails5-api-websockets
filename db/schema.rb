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

ActiveRecord::Schema.define(version: 20160918194125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_v1_canvases", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "diagram_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagram_id"], name: "index_api_v1_canvases_on_diagram_id", using: :btree
  end

  create_table "api_v1_diagrams", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_v1_shapes", force: :cascade do |t|
    t.string   "label",       null: false
    t.string   "shape_type",  null: false
    t.text     "descriptors", null: false
    t.integer  "pos_x",       null: false
    t.integer  "pos_y",       null: false
    t.integer  "canvas_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["canvas_id"], name: "index_api_v1_shapes_on_canvas_id", using: :btree
  end

  create_table "data_files", force: :cascade do |t|
    t.json     "sources"
    t.string   "menu"
    t.string   "dish"
    t.string   "menu_item"
    t.string   "menu_page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dishes", force: :cascade do |t|
    t.string   "description"
    t.integer  "first_appeared"
    t.decimal  "highest_price",        precision: 6, scale: 2
    t.integer  "last_appeared"
    t.decimal  "lowest_price",         precision: 6, scale: 2
    t.integer  "menus_appeared_count"
    t.string   "name"
    t.integer  "times_appeared_count"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_events_on_name", unique: true, using: :btree
  end

  create_table "menu_items", force: :cascade do |t|
    t.integer  "dish_id"
    t.decimal  "high_price",   precision: 10, scale: 2
    t.integer  "menu_page_id"
    t.decimal  "price",        precision: 10, scale: 2
    t.float    "xpos"
    t.float    "ypos"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.index ["dish_id"], name: "index_menu_items_on_dish_id", using: :btree
    t.index ["menu_page_id"], name: "index_menu_items_on_menu_page_id", using: :btree
  end

  create_table "menu_pages", force: :cascade do |t|
    t.integer  "menu_id"
    t.integer  "page_number"
    t.string   "image_id"
    t.integer  "full_height"
    t.integer  "full_width"
    t.uuid     "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["menu_id"], name: "index_menu_pages_on_menu_id", using: :btree
  end

  create_table "menus", force: :cascade do |t|
    t.string   "call_number"
    t.string   "currency"
    t.string   "currency_symbol"
    t.date     "sheduled_on"
    t.integer  "dishes_count"
    t.string   "event_orig"
    t.string   "keywords"
    t.string   "language"
    t.string   "location"
    t.string   "location_type"
    t.string   "name"
    t.text     "notes"
    t.string   "occasion"
    t.integer  "menu_pages_count"
    t.string   "physical_description"
    t.string   "place_orig"
    t.string   "sponsor"
    t.string   "status"
    t.integer  "status_id"
    t.string   "venue_orig"
    t.integer  "event_id"
    t.integer  "place_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["event_id"], name: "index_menus_on_event_id", using: :btree
    t.index ["place_id"], name: "index_menus_on_place_id", using: :btree
  end

  create_table "menus_venues", id: false, force: :cascade do |t|
    t.integer "menu_id"
    t.integer "venue_id"
    t.index ["menu_id", "venue_id"], name: "index_menus_venues_on_menu_id_and_venue_id", unique: true, using: :btree
    t.index ["menu_id"], name: "index_menus_venues_on_menu_id", using: :btree
    t.index ["venue_id"], name: "index_menus_venues_on_venue_id", using: :btree
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_places_on_name", unique: true, using: :btree
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_statuses_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_venues_on_name", unique: true, using: :btree
  end

  add_foreign_key "menu_items", "dishes"
  add_foreign_key "menu_items", "menu_pages"
  add_foreign_key "menu_pages", "menus"
  add_foreign_key "menus", "events"
  add_foreign_key "menus", "places"
  add_foreign_key "menus_venues", "menus"
  add_foreign_key "menus_venues", "venues"
end
