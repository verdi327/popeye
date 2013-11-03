class ChangeColumnNameInExerciseResult < ActiveRecord::Migration
  def change
    rename_column :exercise_results, :success, :was_successful
  end
end
