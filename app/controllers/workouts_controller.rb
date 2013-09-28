class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.all
  end

  def new
    @workout = Workout.new
    @workout.exercises.build
  end

  def show
    @workout = Workout.find(params[:id])
  end

  def edit
    @workout = Workout.find(params[:id])
  end

  def update
    workout = Workout.find(params[:id])
    workout.update_attributes(workout_params)
    redirect_to workouts_path
  end

  def create
    workout = Workout.new(workout_params)
    if workout.save!
      redirect_to workouts_path
    end
  end

  private

  def workout_params
    params.require(:workout).permit(:name, exercises_attributes: [:id, :name, :sets, :reps, :_destroy])
  end
end
