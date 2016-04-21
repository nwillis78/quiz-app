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

ActiveRecord::Schema.define(version: 20160421130118) do

  create_table "answers", force: :cascade do |t|
    t.string   "answerString"
    t.boolean  "isCorrect"
    t.integer  "question_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "categories", force: :cascade do |t|
    t.string   "categoryBody"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id"

  create_table "directions", force: :cascade do |t|
    t.string   "directionName"
    t.string   "directionCode"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "staff_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "languageName"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "direction_id"
    t.integer  "user_id"
  end

  add_index "languages", ["direction_id"], name: "index_languages_on_direction_id"
  add_index "languages", ["user_id"], name: "index_languages_on_user_id"

  create_table "links", force: :cascade do |t|
    t.integer  "quiz_id"
    t.integer  "question_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "question_category"
  end

  add_index "links", ["question_id"], name: "index_links_on_question_id"
  add_index "links", ["quiz_id"], name: "index_links_on_quiz_id"

  create_table "members", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "members", ["group_id"], name: "index_members_on_group_id"

  create_table "questions", force: :cascade do |t|
    t.text     "body"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "language_id"
  end

  add_index "questions", ["category_id"], name: "index_questions_on_category_id"
  add_index "questions", ["language_id"], name: "index_questions_on_language_id"
  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "quizzes", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "instructions"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.integer  "language_id"
    t.integer  "attemptsAllowed"
    t.integer  "time_allowed"
    t.boolean  "shuffleQuestions"
    t.boolean  "shuffleAnswers"
  end

  add_index "quizzes", ["language_id"], name: "index_quizzes_on_language_id"
  add_index "quizzes", ["user_id"], name: "index_quizzes_on_user_id"

  create_table "results", force: :cascade do |t|
    t.integer  "chosen_answer"
    t.integer  "user_quiz_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "question_id"
  end

  add_index "results", ["user_quiz_id"], name: "index_results_on_user_quiz_id"

  create_table "user_quizzes", force: :cascade do |t|
    t.integer  "quiz_id"
    t.integer  "staff_id"
    t.integer  "student_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "attemptsTaken"
    t.datetime "time_started"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "results_available"
    t.integer  "group_id"
  end

  add_index "user_quizzes", ["quiz_id"], name: "index_user_quizzes_on_quiz_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "username"
    t.string   "uid"
    t.string   "mail"
    t.string   "ou"
    t.string   "dn"
    t.string   "sn"
    t.string   "givenname"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["username"], name: "index_users_on_username"

end
