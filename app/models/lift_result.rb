class LiftResult < ActiveRecord::Base
  belongs_to :exercise_result
  after_save :determine_lift_success

  def display_result
    "#{set}: #{achieved_reps} @ #{used_weight}"
  end

  private

  def determine_lift_success
    if goal_reps == achieved_reps
      update_column :was_successful, true
    else
      update_column :was_successful, false
    end
  end
end
