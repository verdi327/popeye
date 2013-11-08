class CreateLiftDetails < ActiveRecord::Migration
  def change
    create_table :lift_details do |t|
      t.integer :set
      t.integer :reps
      t.integer :weight
      t.integer :exercise_id

      t.timestamps
    end
  end
end
