class AddCurrentWeightToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :current_weight, :integer
  end
end
