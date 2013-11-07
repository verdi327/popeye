class ChangeColumnNameRepsToAchievedReps < ActiveRecord::Migration
  def change
    rename_column :lift_results, :reps, :achieved_reps
  end
end
