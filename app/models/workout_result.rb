class WorkoutResult < ActiveRecord::Base
  belongs_to :workout
  has_many :exercise_results, dependent: :destroy
  accepts_nested_attributes_for :exercise_results, allow_destroy: true
end
