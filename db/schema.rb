# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_04_28_164508) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "local_authorities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", force: :cascade do |t|
    t.integer "geograph_id"
    t.string "title"
    t.string "description"
    t.string "subject"
    t.string "creator"
    t.string "creator_uri"
    t.datetime "date_submitted"
    t.float "lat"
    t.float "lon"
    t.text "gridsquare"
    t.string "license_uri"
    t.string "format"
    t.integer "vote_count"
    t.float "random"
    t.integer "width"
    t.integer "height"
    t.float "aspect"
    t.string "image_uri"
    t.string "geograph_image_uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active_on_geograph", default: true
    t.index ["active_on_geograph"], name: "index_places_on_active_on_geograph"
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "place_id"
    t.integer "rating"
    t.uuid "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id", "uuid"], name: "index_votes_on_place_id_and_uuid", unique: true
    t.index ["place_id"], name: "index_votes_on_place_id"
  end

end
