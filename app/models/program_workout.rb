class ProgramWorkout < ActiveRecord::Base
  belongs_to :workout
  belongs_to :program
end
