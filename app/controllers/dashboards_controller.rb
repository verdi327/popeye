class DashboardsController < ApplicationController
  def index
    @active_program = current_user.active_program
    @current_workout = @active_program.workouts.where(id: @active_program.current_workout).first if @active_program
  end

  private

  def has_no_workouts?
    current_user.workouts.empty?
  end
  helper_method :has_no_workouts?
end