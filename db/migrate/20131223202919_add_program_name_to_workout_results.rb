class AddProgramNameToWorkoutResults < ActiveRecord::Migration
  def change
    add_column :workout_results, :program_name, :string
  end
end
