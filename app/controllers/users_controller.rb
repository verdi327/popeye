class UsersController < ApplicationController
  def show
    @active_program = current_user.active_program
    @total_workout_sessions = current_user.workout_results.size
  end
end
