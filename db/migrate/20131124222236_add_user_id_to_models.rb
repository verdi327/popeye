class AddUserIdToModels < ActiveRecord::Migration
  def change
    add_column :workouts, :user_id, :integer
    add_column :programs, :user_id, :integer
    add_column :workout_results, :user_id, :integer
  end
end
