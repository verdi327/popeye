class ProgramsController < ApplicationController

  def index
    @programs = current_user.programs
  end

  def new
    @program = Program.new
    @workouts = current_user.workouts
  end

  def create
    @workouts = current_user.workouts
    @program = Program.new(initial_params)
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
    @program = Program.find(params[:id])
  end

  def destroy
    program = Program.find(params[:id])
    program.destroy
    redirect_to programs_path
  end

  def make_active
    @program = Program.find(params[:id])
    @program.set_as_active
    redirect_to program_path(@program)
  end

  private

  def initial_params
    { name: params[:program][:name],
      user_id: params[:program][:user_id],
      available_in_store: params[:program][:available_in_store],
      skill_level: params[:program][:skill_level],
      description: params[:program][:description]
    }
  end

  def program_params
    params.require(:program).permit(
      :name,
      :user_id,
      :workout_ids,
      :active,
      :available_in_store,
      :skill_level,
      :description
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

end
