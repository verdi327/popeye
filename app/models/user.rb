class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :programs
  has_many :workouts
  has_many :workout_results
  has_many :max_lifts
  has_many :exercises

  def active_program
    programs.where(active: true).first
  end

  def approved_trainer?
    return false if roles.nil?
    roles.include?("approved_trainer")
  end

  def male?
    gender == "male"
  end

  def female?
    gender == "female"
  end

  def no_workouts?
    workouts.empty?
  end

  def has_completed_workouts?
    workout_results.present?
  end

  def no_completed_workouts?
    !has_completed_workouts?
  end
end
