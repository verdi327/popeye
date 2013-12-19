class UpdateExerciseResults < ActiveRecord::Migration
  def change
    remove_column(:exercise_results, :exercise_id, :integer)
    add_column(:exercise_results, :exercise_name, :string)
    add_column(:exercise_results, :next_lift, :string)
  end
end
