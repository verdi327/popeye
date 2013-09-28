class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :reps
      t.integer :sets

      t.timestamps
    end
  end
end
