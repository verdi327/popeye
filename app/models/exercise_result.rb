class ExerciseResult < ActiveRecord::Base
  belongs_to :workout_result
  belongs_to :exercise
  has_many :lift_results, dependent: :destroy
  accepts_nested_attributes_for :lift_results, allow_destroy: true

  after_save :update_exercise_current_weight, if: :success?

  def success?
    lift_results.all? {|lift_result| lift_result.was_successful == true}
  end

  def button_styling
    success? ? "btn-success" : "btn-danger"
  end

  def status_icon
    success? ? "<span class='glyphicon glyphicon-thumbs-up'></span>" : "<span class='glyphicon glyphicon-thumbs-down'></span>"
  end

  def prescribed_lift
    success? ? exercise.routine(past_weight) : exercise.routine
  end

  def next_lift
    exercise.routine
  end

  def past_weight
    exercise.current_weight - exercise.increment_weight_by
  end

  private

  def update_exercise_current_weight
    weight = exercise.current_weight + exercise.increment_weight_by
    exercise.update_attribute :current_weight, weight
  end
end
