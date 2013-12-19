class AddWorkoutNameToWorkoutResults < ActiveRecord::Migration
  def change
    add_column :workout_results, :workout_name, :string
  end
end
