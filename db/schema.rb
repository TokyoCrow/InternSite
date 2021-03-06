# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_31_134411) do

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.string "title", default: "", null: false
    t.text "discription", default: "", null: false
    t.date "date", default: "2000-01-01", null: false
    t.integer "weekday", default: 1, null: false
    t.boolean "repeat_every_day", default: false, null: false
    t.boolean "repeat_every_week", default: false, null: false
    t.boolean "repeat_every_month", default: false, null: false
    t.boolean "repeat_every_year", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
