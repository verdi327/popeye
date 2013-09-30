class Exercise < ActiveRecord::Base
  belongs_to :workout
  validates :name, presence: {message: "an exercise name is required" }
  validates :reps, presence: {message: "number of reps is required" }, numericality: { only_integer: true, greater_than: 0, message: "reps: only whole, positive numbers" }
  validates :sets, presence: {message: "number of sets is required" }, numericality: { only_integer: true, greater_than: 0, message: "sets: only whole, positive numbers" }
  validates :sets, presence: {message: "inital weight required" }, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "initial weight: only whole, positive numbers" }

  def routine
    "#{sets}x#{reps} @ #{initial_weight}lbs"
  end

end
