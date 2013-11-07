class AddIndexToLiftResult < ActiveRecord::Migration
  def change
    add_index(:lift_results, :exercise_result_id)
  end
end
