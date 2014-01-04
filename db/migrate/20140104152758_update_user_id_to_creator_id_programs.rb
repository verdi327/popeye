class UpdateUserIdToCreatorIdPrograms < ActiveRecord::Migration
  def change
    rename_column(:programs, :user_id, :creator_id)
  end
end
