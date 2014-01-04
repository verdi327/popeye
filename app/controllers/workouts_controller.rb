class WorkoutsController < ApplicationController
  before_action :find_workout, only: [:show, :destroy, :confirm_delete]

  def index
    @workouts = current_user.workouts
  end

  def new
    @workout = Workout.new
    @exercises = current_user.exercises
  end

  def show
  end

  def create
    @exercises = current_user.exercises
    @workout = Workout.new(workout_params)
    if @workout.save
      @workout.link_exercises(exercise_ids)
      flash[:notice] = "Workout Created!"
      redirect_to workouts_path
    else
      render "new"
    end
  end

  def confirm_delete
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
      :creator_id
    )
  end

  def exercise_ids
    params[:workout][:exercise_ids].split("_")
  end

  def workout_used_in_programs?
    @workout.programs.present?
  end
  helper_method :workout_used_in_programs?

end
