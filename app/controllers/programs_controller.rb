class ProgramsController < ApplicationController

  def index
    @programs = Program.all
  end

  def new
    @program = Program.new
    @workouts = Workout.all
  end

  def create
    @workouts = Workout.all
    @program = Program.new(name: params[:program][:name])
    if @program.save
      @program.link_workouts(workout_ids)
      @program.set_workout_order(workout_ids)
      @program.update_active(active?)
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
    @program.update_active(true)
    redirect_to program_path(@program)
  end

  private

  def program_params
    params.require(:program).permit(
      :name,
      :workout_ids,
      :active
    )
  end

  def workout_ids
    params[:program][:workout_ids].split("_")
  end

  def active?
    params[:program][:active] == "1"
  end

end
