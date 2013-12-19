class LiftDetail < ActiveRecord::Base
  belongs_to :exercise
  validates :reps, presence: {message: "number of reps is required" }, numericality: { only_integer: true, greater_than: 0, message: "reps: only whole, positive numbers" }
  validates :set, presence: {message: "a set number is required" }, numericality: { only_integer: true, greater_than: 0, message: "sets: only whole, positive numbers" }
  validates :weight, presence: {message: "a weight required" }, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "weight: only whole, positive numbers" }

  def self.by_set
    order(set: :asc)
  end

end
