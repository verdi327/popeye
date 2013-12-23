class DashboardsController < ApplicationController
  def index
    @active_program = current_user.active_program
    @current_workout = @active_program.workouts.where(id: @active_program.current_workout).first if @active_program
  end

  private

  def completed_test_already?
    params[:test_completed].present?
  end
  helper_method :completed_test_already?

end