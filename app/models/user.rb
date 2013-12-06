class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_programs, dependent: :destroy
  has_many :programs, through: :user_programs
  has_many :workouts
  has_many :workout_results

  #move this to helper
  def formatted_date
    date = created_at
    date.strftime("%a, %b #{date.day.ordinalize} %Y")
  end

  def active_program
    programs.where(active: true).first
  end
end
