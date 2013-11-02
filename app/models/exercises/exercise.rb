class Exercise < ActiveRecord::Base
  belongs_to :workout
  validates :name, presence: {message: "an exercise name is required" }
  validates :reps, presence: {message: "number of reps is required" }, numericality: { only_integer: true, greater_than: 0, message: "reps: only whole, positive numbers" }, unless: Proc.new {|exercise| exercise.pyramid_rep?}
  validates :sets, presence: {message: "number of sets is required" }, numericality: { only_integer: true, greater_than: 0, message: "sets: only whole, positive numbers" }
  validates :initial_weight, presence: {message: "initial weight required" }, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "initial weight: only whole, positive numbers" }
  validates :increment_weight_by, presence: {message: "a weight to increment is required" }, numericality: { greater_than_or_equal_to: 0, message: "increment weight: positive numbers" }

  after_save :set_current_weight
  store_accessor :data

  def static_rep?
    type == "StaticRep"
  end

  def pyramid_rep?
    type == "PyramidRep"
  end

  def time_rep?
    type == "TimeRep"
  end

  def self.types_for_select
    {
      "Set Reps (set number of reps and sets)"               => "StaticRep",
      "Pyramid Reps (set number of sets with variable reps)" => "PyramidRep",
      "Time Based (as many reps in a minute)"                => "TimeRep"
    }
  end

  private

  def set_current_weight
    if current_weight.nil?
      update_column :current_weight, initial_weight
    end
  end

end