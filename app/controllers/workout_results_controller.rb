class WorkoutResultsController < ApplicationController
  before_action :find_workout_result, only: [:show, :destroy]

  def index
    @workout_results = current_user.workout_results.order("created_at DESC").page params[:page]
  end

  def new
    @workout_result = WorkoutResult.new(initial_params)
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
    @workout_result = WorkoutResult.find(params[:id])
  end

  def update
    @workout_result = WorkoutResult.find(params[:id])
    @workout_result.update(workout_result_params)
    if @workout_result.save!
      redirect_to workout_result_path(@workout_result)
    else
      render "edit"
    end
  end

  def destroy
    @workout_result.destroy
    redirect_to workout_log_path
  end

  private

  def initial_params
    { workout_id: params[:workout_id], program_id: params[:program_id] }
  end

  def workout_result_params
    params.require(:workout_result).permit(
      :id,
      :workout_id,
      :program_id,
      :user_id,
      :workout_name,
      exercise_results_attributes:
      [
        :id,
        :exercise_id,
        :exercise_name,
        :prescribed_lift,
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
