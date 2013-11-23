class Program < ActiveRecord::Base
  has_many :program_workouts, dependent: :destroy
  has_many :workouts, through: :program_workouts
  validates :name, presence: {message: "a program name is required"}, length: {maximum: 30, message: "program name is too long"}

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
    self.class.where(active: true).size > 0
  end

  def currently_active
    self.class.where(active: true).first
  end

  def update_active(active)
    if active
      if active_already_exists?
        currently_active.update_attribute :active, false
        update_attribute :active, true
      else
        update_attribute :active, true
      end
    end
  end

end

