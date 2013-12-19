class WorkoutResult < ActiveRecord::Base
  belongs_to :workout
  belongs_to :program
  belongs_to :user
  has_many :exercise_results, dependent: :destroy
  accepts_nested_attributes_for :exercise_results, allow_destroy: true
  after_save :update_current_workout, if: Proc.new {|wr| wr.program.present?}

  def success?
    exercise_results.all? {|exercise_result| exercise_result.increase_weight_strategy_met?}
  end

  def lastest_workout?
    self.class.last == self
  end

  def associated_workout_exists?
    Workout.find_by_id(workout_id).present?
  end

  private

  def update_current_workout
    program.next_workout
  end
end
