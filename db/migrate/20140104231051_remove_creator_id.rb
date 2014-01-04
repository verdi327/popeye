class RemoveCreatorId < ActiveRecord::Migration
  def change
    rename_column(:exercises, :creator_id, :user_id)
    rename_column(:workouts, :creator_id, :user_id)
    add_column(:programs, :user_id, :integer)
  end
end
