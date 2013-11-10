class WorkoutResult < ActiveRecord::Base
  belongs_to :workout
  has_many :exercise_results, dependent: :destroy
  accepts_nested_attributes_for :exercise_results, allow_destroy: true

  def formatted_date
    date = created_at
    date.strftime("%a, %b #{date.day.ordinalize} %Y")
  end

  def success?
    exercise_results.all? {|exercise_result| exercise_result.success?}
  end

  def button_styling
    success? ? "btn-success" : "btn-danger"
  end

  def status
    success? ? "Move On Up" : "Try Again"
  end

  def reset_to_previous!
    if success?
      workout.exercises.each do |exercise|
        weight = exercise.current_weight - exercise.increment_weight_by
        exercise.update_attribute(:current_weight, weight)
      end
    end
  end
end
