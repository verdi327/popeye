class AddIncrementWeightByToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :increment_weight_by, :integer
  end
end
