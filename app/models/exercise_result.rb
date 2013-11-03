class ExerciseResult < ActiveRecord::Base
  belongs_to :workout_result
  has_many :lift_results
  accepts_nested_attributes_for :lift_results, allow_destroy: true
end
