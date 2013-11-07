class RemoveWasSuccessfulFromExerciseResult < ActiveRecord::Migration
  def change
    remove_column :exercise_results, :was_successful
  end
end
