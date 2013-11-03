class ChangeSetToStringInLiftResult < ActiveRecord::Migration
  def change
    change_column :lift_results, :set, :string
  end
end
