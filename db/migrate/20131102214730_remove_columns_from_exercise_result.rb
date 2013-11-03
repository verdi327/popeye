class RemoveColumnsFromExerciseResult < ActiveRecord::Migration
  def change
    remove_column :exercise_results, :exercise_weight
    remove_column :exercise_results, :exercise_name
  end
end
