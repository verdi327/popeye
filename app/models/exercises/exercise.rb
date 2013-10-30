class Exercise < ActiveRecord::Base
  belongs_to :workout
  validates :name, presence: {message: "an exercise name is required" }
  validates :reps, presence: {message: "number of reps is required" }, numericality: { only_integer: true, greater_than: 0, message: "reps: only whole, positive numbers" }
  validates :sets, presence: {message: "number of sets is required" }, numericality: { only_integer: true, greater_than: 0, message: "sets: only whole, positive numbers" }
  validates :initial_weight, presence: {message: "inital weight required" }, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "initial weight: only whole, positive numbers" }

  after_save :set_current_weight
  store_accessor :data

  # implement in each sub class
  # def routine
  #   "#{sets}x#{reps} @ #{current_weight}lbs"
  # end

  def self.types_for_select
    {
      "Set Reps (set number of reps and sets)"               => "static_rep",
      "Pyramid Reps (set number of sets with variable reps)" => "pyramid_rep",
      "Time Based (as many reps in a minute)"                => "time_rep"
    }
  end

  private

  def set_current_weight
    if current_weight.nil?
      self.current_weight = initial_weight
      save!
    end
  end

end