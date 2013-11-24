class AddProgramIdToWorkoutResult < ActiveRecord::Migration
  def change
    add_column :workout_results, :program_id, :integer
  end
end
