class ExerciseResult < ActiveRecord::Base
  belongs_to :workout_result
  belongs_to :exercise
  has_many :lift_results, dependent: :destroy
  accepts_nested_attributes_for :lift_results, allow_destroy: true

  after_save :manage_exercise_current_weight

  def success?
    lift_results.all? {|lift_result| lift_result.was_successful == true}
  end

  def failed?
    lift_results.any? {|lift_result| lift_result.was_successful == false}
  end

  def increase_weight_strategy_met?
    results = self.class.where(exercise_id: exercise_id).order(updated_at: :desc).first(exercise.increase_strategy)
    return false if results.size < exercise.increase_strategy
    results.all? {|exercise_result| exercise_result.success? }
  end

  def decrease_weight_strategy_met?
    results = self.class.where(exercise_id: exercise_id).order(updated_at: :desc).first(exercise.decrease_strategy)
    return false if results.size < exercise.decrease_strategy
    results.all? {|exercise_result| exercise_result.failed? }
  end

  private

  def manage_exercise_current_weight
    reset_to_previous! if already_modified?
    if increase_weight_strategy_met?
      update_column :status, "increased"
      exercise.increase_weight
    elsif decrease_weight_strategy_met?
      update_column :status, "decreased"
      exercise.decrease_weight
    else
      update_column :status, "no_change"
    end
    update_column :next_lift, exercise.reload.routine
  end

  def already_modified?
    status != nil
  end

  def reset_to_previous!
    case status
    when "increased" then exercise.decrease_weight
    when "decreased" then exercise.increase_weight
    end
  end

end
