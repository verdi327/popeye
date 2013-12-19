class AddPrescribedLiftToExerciseResults < ActiveRecord::Migration
  def change
    add_column(:exercise_results, :prescribed_lift, :string)
  end
end
