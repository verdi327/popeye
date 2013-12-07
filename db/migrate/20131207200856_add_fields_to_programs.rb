class AddFieldsToPrograms < ActiveRecord::Migration
  def change
    add_column(:programs, :description, :text)
    add_column(:programs, :skill_level, :string)
  end
end
