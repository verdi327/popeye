class AddInitialWeightToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :initial_weight, :integer
  end
end
