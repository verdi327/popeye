class AddClonedFromProgramToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :cloned_from_program, :string
  end
end
