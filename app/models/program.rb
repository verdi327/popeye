class Program < ActiveRecord::Base
  has_many :program_workouts, dependent: :destroy
  has_many :workouts, through: :program_workouts
  belongs_to :user
  validates :name, presence: {message: "a program name is required"}, length: {maximum: 30, message: "program name is too long"}
  validates :description, presence: {message: "a program description is required"}, length: {maximum: 500, message: "description can only be a max of 500 characters"}, if: "available_in_store.present?"
  validates :skill_level, presence: {message: "a skill level is required"}, if: "available_in_store.present?"

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

  def active_already_exists?
    self.class.where(user_id: user_id).where(active: true).size > 0
  end

  def currently_active
    self.class.where(user_id: user_id).where(active: true).first
  end

  def update_active
    if active_already_exists?
      currently_active.update_attribute :active, false
      update_attribute :active, true
    else
      update_attribute :active, true
    end
  end

end

