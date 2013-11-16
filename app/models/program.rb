class Program < ActiveRecord::Base
  has_many :program_workouts, dependent: :destroy
  has_many :workouts, through: :program_workouts
  validates :name, presence: {message: "a program name is required"}, length: {maximum: 30, message: "program name is too long"}
end
