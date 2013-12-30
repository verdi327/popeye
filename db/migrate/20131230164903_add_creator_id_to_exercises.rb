class AddCreatorIdToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :creator_id, :integer
    add_index(:exercises, :creator_id)
  end
end
