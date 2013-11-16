class CreateProgramWorkouts < ActiveRecord::Migration
  def change
    create_table :program_workouts do |t|
      t.integer :program_id
      t.integer :workout_id

      t.timestamps
    end
  end
end
