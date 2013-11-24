class AddMultipleIndexesToModels < ActiveRecord::Migration
  def change
    add_index(:lift_details, :exercise_id)
    add_index(:program_workouts, :program_id)
    add_index(:program_workouts, :workout_id)
    add_index(:workout_results, :program_id)
  end
end
