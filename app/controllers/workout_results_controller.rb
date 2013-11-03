class WorkoutResultsController < ApplicationController
  def new
    @workout_result = WorkoutResult.new(workout_id: params[:workout_id])
    @exercises = @workout_result.workout.exercises
    exercise_results = @workout_result.exercise_results.build
    exercise_results.lift_results.build
  end

  def create
    raise params.inspect
  end

  private

  def workout
    @workout ||= Workout.find(params[:workout_id])
  end
end
