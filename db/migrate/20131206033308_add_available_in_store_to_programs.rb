class AddAvailableInStoreToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :available_in_store, :boolean
  end
end
