class AddDataToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :data, :hstore
  end
end
