class AddIndexToWorkoutResult < ActiveRecord::Migration
  def change
    add_index(:workout_results, :workout_id)
  end
end
