class WorkoutResultsController < ApplicationController
  def new
    @workout_result = WorkoutResult.new(workout_id: params[:workout_id])
    @exercises = @workout_result.workout.exercises
  end

  private

  def workout
    @workout ||= Workout.find(params[:workout_id])
  end
end
