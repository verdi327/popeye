class AddCreatorIdToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :creator_id, :integer
    add_index(:programs, :creator_id)
  end
end
