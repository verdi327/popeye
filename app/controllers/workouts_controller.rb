class WorkoutsController < ApplicationController
  before_action :find_workout, only: [:show, :edit, :update, :destroy, :confirm_delete]

  def index
    @workouts = current_user.workouts
  end

  def new
    @workout = Workout.new
    exercises = @workout.exercises.build
    exercises.lift_details.build
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
      :creator_id,
      exercises_attributes:
      [
        :id,
        :name,
        :increase_weight_by,
        :decrease_weight_by,
        :increase_strategy,
        :decrease_strategy,
        :_destroy,
        lift_details_attributes:
        [
          :id, :set, :reps, :weight, :_destroy
        ]
      ]
    )
  end

  def workout_used_in_programs?
    @workout.programs.present?
  end
  helper_method :workout_used_in_programs?

end
