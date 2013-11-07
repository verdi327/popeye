class AddColumnGoalRepsToLiftResult < ActiveRecord::Migration
  def change
    add_column :lift_results, :goal_reps, :integer
  end
end
