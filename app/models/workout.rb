class Workout < ActiveRecord::Base
  has_many :exercises, dependent: :destroy
  accepts_nested_attributes_for :exercises, allow_destroy: true
  has_many :workout_results
  validates :name, presence: {message: "a workout name is required"}, length: {maximum: 30, message: "workout name too long"}

  def total_attempts
    WorkoutResult.where(workout_id: id).size
  end

end
