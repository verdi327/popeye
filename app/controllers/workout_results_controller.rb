class WorkoutResultsController < ApplicationController
  def index
    @workout_results = WorkoutResult.all
  end

  def new
    @workout_result = WorkoutResult.new(workout_id: params[:workout_id])
    @exercises = @workout_result.workout.exercises
    exercise_results = @workout_result.exercise_results.build
    exercise_results.lift_results.build
  end

  def create
    @workout_result = WorkoutResult.new(workout_result_params)
    if @workout_result.save!
      redirect_to workout_results_path
    else
      render "new"
    end
  end

  private

  def workout_result_params
    params.require(:workout_result).permit(
      :workout_id,
      exercise_results_attributes:
      [
        :id,
        :exercise_id,
        lift_results_attributes:
        [
          :set,
          :reps,
          :intended_weight,
          :used_weight
        ]
      ]
    )
  end

end
