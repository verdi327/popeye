class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :programs, foreign_key: "creator_id"
  has_many :workouts, foreign_key: "creator_id"
  has_many :workout_results
  has_many :max_lifts
  has_many :exercises, foreign_key: "creator_id"

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
end
