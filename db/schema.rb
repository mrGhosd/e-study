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

ActiveRecord::Schema.define(version: 20160901223759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attaches", force: :cascade do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "attaches", ["attachable_id"], name: "index_attaches_on_attachable_id", using: :btree
  add_index "attaches", ["attachable_type"], name: "index_attaches_on_attachable_type", using: :btree

  create_table "authorizations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "platform"
    t.string   "platform_version"
    t.string   "app_name"
    t.string   "app_version"
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["last_sign_in_at"], name: "index_authorizations_on_last_sign_in_at", using: :btree
  add_index "authorizations", ["provider"], name: "index_authorizations_on_provider", using: :btree
  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id", using: :btree

  create_table "chats", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",          null: false
    t.text     "text",             null: false
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string "name",       null: false
    t.string "phone_code", null: false
  end

  add_index "countries", ["name"], name: "index_countries_on_name", using: :btree
  add_index "countries", ["phone_code"], name: "index_countries_on_phone_code", using: :btree

  create_table "course_students", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_students", ["course_id"], name: "index_course_students_on_course_id", using: :btree
  add_index "course_students", ["student_id"], name: "index_course_students_on_student_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title",                                             null: false
    t.text     "description",                                       null: false
    t.integer  "user_id",                                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.text     "short_description"
    t.datetime "begin_date",        default: '2016-08-22 00:00:00'
    t.datetime "end_date",          default: '2016-09-22 00:00:00'
    t.integer  "difficult",         default: 0
    t.boolean  "active",            default: true
  end

  add_index "courses", ["description"], name: "index_courses_on_description", using: :btree
  add_index "courses", ["slug"], name: "index_courses_on_slug", unique: true, using: :btree
  add_index "courses", ["title"], name: "index_courses_on_title", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "homeworks", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "text",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_id"
  end

  add_index "homeworks", ["user_id"], name: "index_homeworks_on_user_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "title",                       null: false
    t.integer  "course_id",                   null: false
    t.integer  "user_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",                 null: false
    t.string   "slug"
    t.integer  "teacher_id"
    t.boolean  "active",      default: true
    t.boolean  "is_repeated", default: false
    t.datetime "begin_date"
    t.integer  "period"
  end

  add_index "lessons", ["slug"], name: "index_lessons_on_slug", unique: true, using: :btree
  add_index "lessons", ["teacher_id"], name: "index_lessons_on_teacher_id", using: :btree
  add_index "lessons", ["title"], name: "index_lessons_on_title", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "chat_id",    null: false
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["chat_id"], name: "index_messages_on_chat_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "notificationable_type"
    t.integer  "notificationable_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["active"], name: "index_notifications_on_active", using: :btree
  add_index "notifications", ["notificationable_id"], name: "index_notifications_on_notificationable_id", using: :btree

  create_table "que_jobs", id: false, force: :cascade do |t|
    t.integer  "priority",    limit: 2, default: 100,                                        null: false
    t.datetime "run_at",                default: "now()",                                    null: false
    t.integer  "job_id",      limit: 8, default: "nextval('que_jobs_job_id_seq'::regclass)", null: false
    t.text     "job_class",                                                                  null: false
    t.json     "args",                  default: [],                                         null: false
    t.integer  "error_count",           default: 0,                                          null: false
    t.text     "last_error"
    t.text     "queue",                 default: "",                                         null: false
  end

  create_table "user_chats", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "chat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "password_digest",                                 null: false
    t.datetime "date_of_birth"
    t.text     "description"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_sign_in_at", default: '2016-08-22 00:00:00', null: false
    t.string   "phone"
    t.string   "phone_code"
  end

  add_index "users", ["date_of_birth"], name: "index_users_on_date_of_birth", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["password_digest"], name: "index_users_on_password_digest", using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", unique: true, using: :btree

end
