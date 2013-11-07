class ExerciseResult < ActiveRecord::Base
  belongs_to :workout_result
  belongs_to :exercise
  has_many :lift_results, dependent: :destroy
  accepts_nested_attributes_for :lift_results, allow_destroy: true

  def success?
    lift_results.all? {|lift_result| lift_result.was_successful == true}
  end
end
