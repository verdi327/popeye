class Workout < ActiveRecord::Base
  has_many :exercise_workouts, dependent: :destroy
  # has_many :exercises, through: :exercise_workouts
  has_many :workout_results

  #this callback needs to come before the dependent destroy for program_workouts, otherwise the
  #association is deleted beforehand and this callback will not run bc workout.programs will return nil.
  before_destroy :delete_workout_from_programs, if: Proc.new {|workout| workout.programs.present?}

  has_many :program_workouts, dependent: :destroy
  has_many :programs, through: :program_workouts
  belongs_to :user
  validates :name, presence: {message: "a workout name is required"}, length: {maximum: 30, message: "workout name too long"}

  def exercises
    ex_workout_ids = exercise_workouts.map(&:exercise_id)
    ex_workout_ids.map {|id| Exercise.where(id: id)}.flatten
  end

  def total_attempts
    WorkoutResult.where(workout_id: id).size
  end

  def link_exercises(exercise_ids)
    unless exercise_ids.blank?
      exercise_ids.each do |exercise_id|
        ExerciseWorkout.create(workout_id: id, exercise_id: exercise_id)
      end
    end
  end

  private

  def delete_workout_from_programs
    programs.each do |program|
      if program.current_workout == id
        program.next_workout
      end
      program.workout_order.delete(id.to_s)
      if program.workout_order.size == 0
        program.destroy
      else
        program.workout_order = program.workout_order.map(&:to_i)
        program.save!
      end
    end
  end


end
