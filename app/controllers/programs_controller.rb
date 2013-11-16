class ProgramsController < ApplicationController
  def new
    @program = Program.new
    @workouts = Workout.all
  end

  def create
    @workouts = Workout.all
    @program = Program.new(name: params[:program][:name])
    if @program.save
      link_workouts_to_program(@program.id)
      redirect_to programs_path
    else
      render :new
    end
  end

  def show
    @program = Program.find(params[:id])
  end

  private

  def program_params
    params.require(:program).permit(
      :name,
      :workout_ids
    )
  end

  def workout_ids
    params[:program][:workout_ids].split("_")
  end

  def link_workouts_to_program(program_id)
    unless workout_ids.blank?
      workout_ids.each do |id|
        ProgramWorkout.create!(program_id: program_id, workout_id: id)
      end
    end
  end
end
