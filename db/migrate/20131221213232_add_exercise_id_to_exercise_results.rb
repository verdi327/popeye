class AddExerciseIdToExerciseResults < ActiveRecord::Migration
  def change
    add_column :exercise_results, :exercise_id, :integer
  end
end
