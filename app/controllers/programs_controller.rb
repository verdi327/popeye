class ProgramsController < ApplicationController
  before_action :find_program, only: [:show, :destroy, :make_active, :current_weight_metrics, :update_current_weight_metrics]
  before_action :require_exercise_weights, only: [:update_current_weight_metrics]
  before_action :check_for_mobile

  def index
    @programs = current_user.programs
  end

  def new
    @program = Program.new
    @workouts = current_user.workouts
  end

  def create
    @workouts = current_user.workouts
    @program = Program.new(program_params)
    if @program.save
      @program.link_workouts(workout_ids)
      @program.set_workout_order(workout_ids)
      @program.set_as_active if active?
      redirect_to programs_path
    else
      render :new
    end
  end

  def show
    if params[:store_view]
      render :store_view
    else
      if params[:new_from_store]
        flash[:notice] = "Before you begin make sure to set your proper starting weight by clicking 'View Exercise Weight' below"
      end
    end
  end

  def destroy
    @program.destroy_with_workouts_and_exercises
    redirect_to programs_path
  end

  def make_active
    @program.set_as_active
    redirect_to program_path(@program)
  end

  def current_weight_metrics
  end

  def update_current_weight_metrics
    @program.update_exercise_weights(params[:exercises])
    flash[:notice] = "Current weight successfully updated"
    redirect_to program_path(@program)
  end

  private

  def find_program
    @program = Program.find(params[:id])
  end

  def program_params
    params.require(:program).permit(
      :name,
      :user_id,
      :creator_id,
      :available_in_store,
      :skill_level,
      :description,
      :retest_frequency
    )
  end

  def workout_ids
    params[:program][:workout_ids].split("_")
  end

  def active?
    params[:program][:active] == "1"
  end

  def skill_levels
    SKILL_LEVELS
  end
  helper_method :skill_levels

  def require_exercise_weights
    if weight_values.any? {|weight| weight.blank? || weight.to_i < 0}
      flash[:error] = "Every exercise must have a positive weight value present"
      redirect_to current_weight_metrics_program_path(@program)
      return
    end
  end

  def weight_values
    params[:exercises].values.inject([]) do |weight_values, lift_details|
      weight_values += lift_details.values; weight_values
    end
  end

end
