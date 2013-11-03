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

ActiveRecord::Schema.define(version: 20131103004358) do

  create_table "exercise_results", force: true do |t|
    t.integer  "workout_result_id"
    t.integer  "exercise_id"
    t.boolean  "was_successful"
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

  create_table "lift_results", force: true do |t|
    t.integer  "exercise_result_id"
    t.string   "set"
    t.integer  "reps"
    t.integer  "intended_weight"
    t.integer  "used_weight"
    t.boolean  "was_successful"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workout_results", force: true do |t|
    t.integer  "workout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workout_results", ["workout_id"], name: "index_workout_results_on_workout_id", using: :btree

  create_table "workouts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
