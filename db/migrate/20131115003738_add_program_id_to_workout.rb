class AddProgramIdToWorkout < ActiveRecord::Migration
  def change
    add_column :workouts, :program_id, :integer
  end
end
