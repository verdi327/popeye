class CreateMaxLifts < ActiveRecord::Migration
  def change
    create_table :max_lifts do |t|
      t.integer :user_id
      t.string :exercise_name
      t.integer :weight

      t.timestamps
    end
  end
end
