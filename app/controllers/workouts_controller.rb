class WorkoutsController < ApplicationController
  before_action :find_workout, only: [:show, :edit, :update, :destroy]

  def index
    @workouts = Workout.all
    @active_program = Program.active
    @current_workout = Workout.find_by_id(@active_program.current_workout) if @active_program
  end

  def new
    @workout = Workout.new
    @workout.exercises.build
  end

  def show
  end

  def edit
  end

  def update
    if @workout.update(workout_params)
      redirect_to workouts_path
    else
      render "edit"
    end
  end

  def create
    @workout = Workout.new(workout_params)
    if @workout.save
      flash[:notice] = "Workout Created!"
      redirect_to workouts_path
    else
      render "new"
    end
  end

  def destroy
    @workout.destroy
    flash[:notice] = "Workout Toasted"
    redirect_to workouts_path
  end

  private

  def find_workout
    @workout = Workout.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(
      :name,
      exercises_attributes:
      [
        :id, :name, :sets, :reps, :initial_weight, :type, :time, :increment_weight_by,
        :delta_rep, :delta_weight, :direction, :start_rep, :_destroy
      ]
    )
  end

end
