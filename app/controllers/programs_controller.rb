class ProgramsController < ApplicationController
  def new
    @program = Program.new
    @workouts = Workout.all
  end
end
