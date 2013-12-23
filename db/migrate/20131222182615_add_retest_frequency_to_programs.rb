class AddRetestFrequencyToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :retest_frequency, :integer
  end
end
