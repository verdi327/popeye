class CreateLiftResults < ActiveRecord::Migration
  def change
    create_table :lift_results do |t|
      t.integer :exercise_result_id
      t.integer :set
      t.integer :reps
      t.integer :intended_weight
      t.integer :used_weight
      t.boolean :was_successful

      t.timestamps
    end
  end
end
