class AddMultipleIndexesToMultipleModels < ActiveRecord::Migration
  def change
    add_index(:exercises, :workout_id)
    add_index(:exercise_results, :workout_result_id)
    add_index(:exercise_results, :exercise_id)
  end
end
