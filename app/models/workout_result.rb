class WorkoutResult < ActiveRecord::Base
  belongs_to :workout
  has_many :exercise_results, dependent: :destroy
  accepts_nested_attributes_for :exercise_results, allow_destroy: true

  def formatted_date
    date = created_at
    date.strftime("%a, %b #{date.day.ordinalize}")
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
end
