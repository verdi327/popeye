class ChangeUserIdToCreatorIdInWorkouts < ActiveRecord::Migration
  def change
    rename_column(:workouts, :user_id, :creator_id)
  end
end
