class AddIndexesToUserPrograms < ActiveRecord::Migration
  def change
    add_index(:user_programs, :user_id)
    add_index(:user_programs, :program_id)
  end
end
