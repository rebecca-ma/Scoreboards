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

ActiveRecord::Schema.define(version: 20170521011929) do

  create_table "admins", force: :cascade do |t|
    t.string   "username"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "mission_id"
    t.datetime "start_time"
    t.datetime "completed_time"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["mission_id"], name: "index_assignments_on_mission_id"
    t.index ["team_id"], name: "index_assignments_on_team_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "visible"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "captions", force: :cascade do |t|
    t.integer  "photo_id"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_captions_on_photo_id"
  end

  create_table "missions", force: :cascade do |t|
    t.text     "description"
    t.string   "title"
    t.string   "giver"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "photos", force: :cascade do |t|
    t.text     "caption"
    t.integer  "user_id"
    t.integer  "team_id"
    t.boolean  "admin_uploaded"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["team_id"], name: "index_photos_on_team_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "score"
    t.integer  "team_id"
    t.integer  "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_scores_on_board_id"
    t.index ["team_id"], name: "index_scores_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.boolean  "npc"
    t.string   "code"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "encrypted_password"
    t.string   "salt"
    t.integer  "team_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["team_id"], name: "index_users_on_team_id"
  end

end
