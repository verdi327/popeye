class Program < ActiveRecord::Base
  has_many :program_workouts, dependent: :destroy
  has_many :workouts, through: :program_workouts
  has_many :user_programs
  has_many :users, through: :user_programs
  validates :name, presence: {message: "a program name is required"}, length: {maximum: 30, message: "program name is too long"}
  validates :description, presence: {message: "a program description is required"}, length: {maximum: 500, message: "description can only be a max of 500 characters"}, if: "available_in_store.present?"
  validates :skill_level, presence: {message: "a skill level is required"}, if: "available_in_store.present?"
  after_create :create_user_program_record

  scope :available_in_store, Proc.new { where(available_in_store: true) }

  def next_workout
    current_index = workout_order.find_index(current_workout.to_s)
    next_index = current_index + 1
    if workout_order[next_index].nil?
      next_index = 0
    end
    update_attribute :current_workout, workout_order[next_index]
  end

  def link_workouts(workout_ids)
    unless workout_ids.blank?
      workout_ids.each do |workout_id|
        ProgramWorkout.create!(program_id: id, workout_id: workout_id)
      end
    end
  end

  def set_workout_order(workout_ids)
    unless workout_ids.blank?
      update_attribute :workout_order, workout_ids
      update_attribute :current_workout, workout_ids.first
    end
  end

  def active_already_exists?(user)
    user.programs.where(active: true).size > 0
  end

  def current_active_program(user)
    user.programs.where(active: true).first
  end

  def set_as_active(user)
    if active_already_exists?(user)
      current_active_program(user).update_attribute :active, false
      update_attribute :active, true
    else
      update_attribute :active, true
    end
  end

  private

  def create_user_program_record
    UserProgram.create(program_id: id, user_id: creator_id)
  end

end

