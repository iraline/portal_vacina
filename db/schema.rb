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

ActiveRecord::Schema[7.0].define(version: 2022_05_02_154333) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "localities", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.bigint "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_localities_on_city_id"
    t.index ["state_id", "city_id"], name: "index_localities_on_state_id_and_city_id", unique: true
    t.index ["state_id"], name: "index_localities_on_state_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.date "born_at", null: false
    t.bigint "locality_id", null: false
    t.string "cpf", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_people_on_cpf", unique: true
    t.index ["locality_id"], name: "index_people_on_locality_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "shots", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "locality_id", null: false
    t.bigint "vaccine_id", null: false
    t.bigint "unity_id", null: false
    t.date "shot_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locality_id"], name: "index_shots_on_locality_id"
    t.index ["person_id"], name: "index_shots_on_person_id"
    t.index ["unity_id"], name: "index_shots_on_unity_id"
    t.index ["vaccine_id"], name: "index_shots_on_vaccine_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_states_on_name", unique: true
  end

  create_table "unities", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_unities_on_name", unique: true
  end

  create_table "vaccines", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_vaccines_on_name", unique: true
  end

  add_foreign_key "localities", "cities"
  add_foreign_key "localities", "states"
  add_foreign_key "people", "localities"
  add_foreign_key "shots", "localities"
  add_foreign_key "shots", "people"
  add_foreign_key "shots", "unities"
  add_foreign_key "shots", "vaccines"
end
