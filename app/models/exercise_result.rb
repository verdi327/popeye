class ExerciseResult < ActiveRecord::Base
  belongs_to :workout_result
  belongs_to :exercise
  has_many :lift_results, dependent: :destroy
  accepts_nested_attributes_for :lift_results, allow_destroy: true

  def success?
    lift_results.all? {|lift_result| lift_result.was_successful == true}
  end

  def button_styling
    success? ? "btn-success" : "btn-danger"
  end

  def status
    success? ? "<span class='glyphicon glyphicon-thumbs-up'></span>" : "<span class='glyphicon glyphicon-thumbs-down'></span>"
  end
end
