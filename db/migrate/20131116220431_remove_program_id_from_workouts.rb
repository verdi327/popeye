class RemoveProgramIdFromWorkouts < ActiveRecord::Migration
  def change
    remove_column :workouts, :program_id
  end
end
