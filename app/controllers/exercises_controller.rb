class ExercisesController < ApplicationController
  before_action :find_exercise, only: [:edit, :update]

  def index
    @exercises = current_user.exercises
  end

  def new
    @exercise = Exercise.new
    @exercise.lift_details.build
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      flash[:notice] = "Exercise successfully created"
      redirect_to exercises_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      flash[:notice] = "Exercise Successfully Updated"
      redirect_to exercises_path
    else
      render "edit"
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(
      :name,
      :increase_weight_by,
      :decrease_weight_by,
      :increase_strategy,
      :decrease_strategy,
      :creator_id,
      lift_details_attributes:
      [
        :id, :set, :reps, :weight, :_destroy
      ]
    )
  end

  def find_exercise
    @exercise = Exercise.find(params[:id])
  end
end