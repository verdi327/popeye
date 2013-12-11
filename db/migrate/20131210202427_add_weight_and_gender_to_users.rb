class AddWeightAndGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :weight, :integer
    add_column :users, :gender, :string
  end
end
