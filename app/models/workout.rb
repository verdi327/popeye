class Workout < ActiveRecord::Base
  has_many :exercises, dependent: :destroy
  accepts_nested_attributes_for :exercises, allow_destroy: true
  validates :name, presence: {message: "a workout name is required"}, length: {maximum: 30, message: "workout name too long"}
  after_create :set_current_weight_for_each_exercise

  private

  def set_current_weight_for_each_exercise
    exercises.each do |exercise|
      if exercise.initial_weight.present?
        exercise.update_attribute :current_weight, exercise.initial_weight
      else
        exercise.update_attribute :current_weight, 0
      end
    end
  end

end
