class CreateWorkoutResults < ActiveRecord::Migration
  def change
    create_table :workout_results do |t|
      t.integer :workout_id

      t.timestamps
    end
  end
end
