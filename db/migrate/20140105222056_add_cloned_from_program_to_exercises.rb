class AddClonedFromProgramToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :cloned_from_program, :string
  end
end
