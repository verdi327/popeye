class RemoveLiftDetailFromExerciseResult < ActiveRecord::Migration
  def change
    remove_column :exercise_results, :lift_details
  end
end
