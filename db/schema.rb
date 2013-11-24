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

ActiveRecord::Schema.define(version: 20131124153656) do

  create_table "exercise_results", force: true do |t|
    t.integer  "workout_result_id"
    t.integer  "exercise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercise_results", ["exercise_id"], name: "index_exercise_results_on_exercise_id", using: :btree
  add_index "exercise_results", ["workout_result_id"], name: "index_exercise_results_on_workout_result_id", using: :btree

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.integer  "reps"
    t.integer  "sets"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "workout_id"
    t.integer  "initial_weight"
    t.integer  "current_weight"
    t.string   "type"
    t.integer  "increment_weight_by"
    t.hstore   "data"
  end

  add_index "exercises", ["workout_id"], name: "index_exercises_on_workout_id", using: :btree

  create_table "lift_details", force: true do |t|
    t.integer  "set"
    t.integer  "reps"
    t.integer  "weight"
    t.integer  "exercise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lift_details", ["exercise_id"], name: "index_lift_details_on_exercise_id", using: :btree

  create_table "lift_results", force: true do |t|
    t.integer  "exercise_result_id"
    t.integer  "set"
    t.integer  "achieved_reps"
    t.integer  "intended_weight"
    t.integer  "used_weight"
    t.boolean  "was_successful"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "goal_reps"
  end

  add_index "lift_results", ["exercise_result_id"], name: "index_lift_results_on_exercise_result_id", using: :btree

  create_table "program_workouts", force: true do |t|
    t.integer  "program_id"
    t.integer  "workout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "program_workouts", ["program_id"], name: "index_program_workouts_on_program_id", using: :btree
  add_index "program_workouts", ["workout_id"], name: "index_program_workouts_on_workout_id", using: :btree

  create_table "programs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "workout_order",   array: true
    t.integer  "current_workout"
    t.boolean  "active"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workout_results", force: true do |t|
    t.integer  "workout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "program_id"
  end

  add_index "workout_results", ["program_id"], name: "index_workout_results_on_program_id", using: :btree
  add_index "workout_results", ["workout_id"], name: "index_workout_results_on_workout_id", using: :btree

  create_table "workouts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
