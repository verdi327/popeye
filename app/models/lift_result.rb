class LiftResult < ActiveRecord::Base
  belongs_to :exercise_result
  after_save :determine_lift_success

  default_scope { order(set: :asc) }

  private

  def determine_lift_success
    if goal_reps == achieved_reps
      update_column :was_successful, true
    else
      update_column :was_successful, false
    end
  end
end
