class AddStatusToExerciseResults < ActiveRecord::Migration
  def change
    add_column :exercise_results, :status, :string
  end
end
