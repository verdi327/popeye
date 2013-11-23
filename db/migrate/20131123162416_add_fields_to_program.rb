class AddFieldsToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :workout_order, :text, array: true
    add_column :programs, :current_workout, :integer
  end
end
