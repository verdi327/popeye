class Program < ActiveRecord::Base
  has_many :program_workouts, dependent: :destroy
  has_many :workouts, through: :program_workouts
  has_many :workout_results
  belongs_to :user
  validates :name, presence: {message: "a program name is required"}, length: {maximum: 30, message: "program name is too long"}
  validates :description, presence: {message: "a program description is required"}, length: {maximum: 1000, message: "description can only be a max of 500 characters"}, if: "available_in_store.present?"
  validates :skill_level, presence: {message: "a skill level is required"}, if: "available_in_store.present?"
  validates :retest_frequency, presence: {message: "retest frequency is required" }, numericality: { greater_than_or_equal_to: 1, message: "only positive whole numbers" }


  scope :available_in_store, Proc.new { where(available_in_store: true) }
  scope :beginner_programs, Proc.new { available_in_store.where(skill_level: "beginner") }
  scope :intermediate_programs, Proc.new { available_in_store.where(skill_level: "intermediate") }
  scope :advanced_programs, Proc.new { available_in_store.where(skill_level: "advanced") }

  def next_workout
    current_index = workout_order.find_index(current_workout.to_s)
    next_index = current_index + 1
    if workout_order[next_index].nil?
      next_index = 0
    end
    update_attribute :current_workout, workout_order[next_index]
  end

  def link_workouts(workout_ids, program_id=id)
    unless workout_ids.blank?
      workout_ids.each do |workout_id|
        ProgramWorkout.create!(program_id: program_id, workout_id: workout_id)
      end
    end
  end

  def set_workout_order(workout_ids)
    unless workout_ids.blank?
      update_attribute :workout_order, workout_ids
      update_attribute :current_workout, workout_ids.first
    end
  end

  def set_as_active
    if active_already_exists?
      currently_active.update_attribute :active, false
      update_attribute :active, true
    else
      update_attribute :active, true
    end
  end

  def copy_to_user(user)
    program_copy = create_program_copy(user)
    workout_to_copy_mapping = create_workout_copies(program_copy)
    exercise_to_copy_mapping = create_exercise_copies(workout_to_copy_mapping)
    copy_lift_details(exercise_to_copy_mapping)
  end

  def exercises
    workouts.map {|workout| workout.exercises}.flatten
  end

  # First key is the exercise id
  # doing this switching bc some exercises weight remains the same for all of their lifts where others
  # are pyramid type which need the specific weight passed for each set.
  # {"1"=>{"3"=>"100", "2"=>"90", "1"=>"80"}, "2"=>{"4"=>"200"}}
  def update_exercise_weights(exercise_data)
    exercise_data.each do |ex_id, lift_details|
      if lift_details.values.size == 1
        ex = Exercise.find_by_id ex_id
        ex.lift_details.each {|ld| ld.weight = lift_details.values.first; ld.save }
      else
        lift_details.each do |ld_id, weight|
          ld = LiftDetail.find_by_id ld_id
          ld.weight = weight
          ld.save
        end
      end
    end
  end

  def retest_max_lifts?
    completed_workouts = workout_results.size
    return false if completed_workouts == 0
    completed_workouts % retest_frequency == 0
  end

  def destroy_with_workouts_and_exercises
    workouts.each do |workout|
      workout.exercises.each do |exercise|
        exercise.destroy
      end
      workout.destroy
    end
    destroy
  end

  def self.intermediate_store_programs
    intermediate_programs.where(user_id: system_user.id)
  end

  def self.advanced_store_programs
    advanced_programs.where(user_id: system_user.id)
  end

  private

  def active_already_exists?
    self.class.where(user_id: user_id).where(active: true).size > 0
  end

  def currently_active
    self.class.where(user_id: user_id).where(active: true).first
  end

  def create_program_copy(user)
    program_copy = dup
    program_copy.save
    program_copy.update_attributes(user_id: user.id, creator_id: creator_id)
    program_copy
  end

  def create_workout_copies(program_copy)
    workout_to_copy_mapping = {}
    workout_copies = workouts.map do |workout|
      copy = workout.dup
      copy.update_attributes(user_id: program_copy.user_id, cloned_from_program: name)
      copy.save
      workout_to_copy_mapping[workout.id] = copy.id
      copy
    end
    copied_workout_ids = workout_copies.map(&:id)
    program_copy.update_attributes(workout_order: copied_workout_ids, current_workout: copied_workout_ids.first )
    link_workouts(copied_workout_ids, program_copy.id)
    workout_to_copy_mapping
  end

  def create_exercise_copies(workout_to_copy_mapping)
    exercise_to_copy_mapping = {}
    workout_to_copy_mapping.each do |original_id, copy_id|
      original = Workout.find_by_id original_id
      copy = Workout.find_by_id copy_id
      copied_exercise_ids = original.exercises.map do |exercise|
        if exercise_to_copy_mapping[exercise.id]
          exercise_to_copy_mapping[exercise.id]
        else
          ex_copy = exercise.dup
          ex_copy.update_attributes(user_id: copy.user_id, cloned_from_program: original.cloned_from_program)
          ex_copy.save
          exercise_to_copy_mapping[exercise.id] = ex_copy.id
          ex_copy.id
        end
      end
      link_exercises(copied_exercise_ids, copy_id)
    end
    exercise_to_copy_mapping
  end

  def copy_lift_details(exercise_to_copy_mapping)
    exercise_to_copy_mapping.each do |original_id, copy_id|
      original = Exercise.find_by_id original_id
      original.lift_details.each do |detail|
        ld_copy = detail.dup
        ld_copy.save
        ld_copy.update_attribute :exercise_id, copy_id
      end
    end
  end

  def link_exercises(copied_exercise_ids, workout_copy_id)
    copied_exercise_ids.each do |exercise_id|
      ExerciseWorkout.create(exercise_id: exercise_id, workout_id: workout_copy_id)
    end
  end

  def self.system_user
    @user ||= User.find_by_email "god@popeyeapp.com"
  end

end

