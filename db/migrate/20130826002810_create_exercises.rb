class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string  :name
      t.integer :workout_id
      t.integer :increase_weight_by
      t.integer :decrease_weight_by
      t.integer :increase_strategy
      t.integer :decrease_strategy

      t.timestamps
    end
  end
end
