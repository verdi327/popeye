class WorkoutResultsController < ApplicationController
  before_action :find_workout_result, only: [:show, :destroy]

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

  def show
  end

  def edit
    old_result = WorkoutResult.find(params[:id])
    old_result.reset_to_previous!
    @workout_result = WorkoutResult.new(workout_id: old_result.workout_id)
    old_result.destroy
    @exercises = @workout_result.workout.exercises
    exercise_results = @workout_result.exercise_results.build
    exercise_results.lift_results.build
  end

  # def update
  #   if @workout_result.update(workout_result_params)
  #     redirect_to workout_result_path(@workout_result)
  #   else
  #     render "edit"
  #   end
  # end

  def destroy
    @workout_result.destroy
    redirect_to workout_log_path
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
          :id,
          :set,
          :goal_reps,
          :achieved_reps,
          :intended_weight,
          :used_weight
        ]
      ]
    )
  end

  def find_workout_result
    @workout_result ||= WorkoutResult.find(params[:id])
  end

end
