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

ActiveRecord::Schema.define(version: 20160316175210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_blocked_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_blocked_users", ["user_id", "course_id"], name: "index_course_blocked_users_on_user_id_and_course_id", unique: true, using: :btree

  create_table "course_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "block",      default: false
  end

  add_index "course_users", ["user_id", "course_id"], name: "index_course_users_on_user_id_and_course_id", unique: true, using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
    t.integer  "user_id",    null: false
  end

  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "homeworks", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "title"
    t.integer  "position"
    t.string   "description"
    t.string   "picture"
    t.string   "summary"
    t.string   "homework"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",     default: true
    t.date     "date"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "rokes", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rokes", ["name", "resource_type", "resource_id"], name: "index_rokes_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "rokes", ["name"], name: "index_rokes_on_name", using: :btree

  create_table "social_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "service_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "social_profiles", ["user_id", "service_name"], name: "index_social_profiles_on_user_id_and_service_name", unique: true, using: :btree
  add_index "social_profiles", ["user_id"], name: "index_social_profiles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_rokes", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "roke_id"
  end

  add_index "users_rokes", ["user_id", "roke_id"], name: "index_users_rokes_on_user_id_and_roke_id", using: :btree

end
