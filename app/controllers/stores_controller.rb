class StoresController < ApplicationController
  def index
  end

  def beginner
    @program = Program.beginner_programs.first
  end

  def intermediate

  end

  def advanced

  end

  def copy_to_user
    program = Program.find params[:program_id]
    program.copy_to_user(current_user)
    new_program = current_user.programs.reload.last
    redirect_to program_path(new_program, new_from_store: true)
  end
end
