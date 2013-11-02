class CreateExerciseResults < ActiveRecord::Migration
  def change
    create_table :exercise_results do |t|
      t.integer :workout_result_id
      t.integer :exercise_weight
      t.string :exercise_name
      t.integer :exercise_id
      t.boolean :success
      t.hstore :lift_details

      t.timestamps
    end
  end
end
