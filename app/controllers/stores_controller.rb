class StoresController < ApplicationController
  def index
  end

  def beginner
    @program = Program.beginner_programs.first
  end

  def intermediate
    @programs = Program.intermediate_programs
  end

  def advanced
    @programs = Program.advanced_programs
  end

  def copy_to_user
    program = Program.find params[:program_id]
    program.copy_to_user(current_user)
    new_program = current_user.programs.reload.where(name: program.name).first
    new_program.set_as_active
    redirect_to program_path(new_program, new_from_store: true)
  end
end
