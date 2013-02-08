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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130207152952) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "body"
    t.integer  "is_valid"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "attachments", :force => true do |t|
    t.integer  "user_id"
    t.string   "attachment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "attachments", ["user_id"], :name => "index_attachments_on_user_id"

  create_table "groups", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "groups", ["user_id"], :name => "index_groups_on_user_id"

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  add_index "groups_users", ["group_id", "user_id"], :name => "index_groups_users_on_group_id_and_user_id"
  add_index "groups_users", ["user_id", "group_id"], :name => "index_groups_users_on_user_id_and_group_id"

  create_table "questions", :force => true do |t|
    t.integer  "workout_id"
    t.text     "body"
    t.string   "answer_type"
    t.boolean  "random_answers"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "questions", ["workout_id"], :name => "index_questions_on_workout_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "workout_passes", :force => true do |t|
    t.integer  "assigned_by_id"
    t.integer  "owner_id"
    t.integer  "assigned_to_id"
    t.integer  "workout_id"
    t.integer  "total_time"
    t.date     "start_time"
    t.date     "end_time"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "workout_passes", ["assigned_by_id"], :name => "index_workout_passes_on_assigned_by_id"
  add_index "workout_passes", ["assigned_to_id"], :name => "index_workout_passes_on_assigned_to_id"
  add_index "workout_passes", ["owner_id"], :name => "index_workout_passes_on_owner_id"
  add_index "workout_passes", ["workout_id"], :name => "index_workout_passes_on_workout_id"

  create_table "workouts", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.boolean  "allow_question_skip"
    t.boolean  "warn_empty_questions"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "workouts", ["user_id"], :name => "index_workouts_on_user_id"

end
