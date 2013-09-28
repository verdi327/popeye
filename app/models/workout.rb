class Workout < ActiveRecord::Base
  has_many :exercises, dependent: :destroy
  accepts_nested_attributes_for :exercises, allow_destroy: true
  validates :name, presence: {message: "a workout name is required"}, length: {maximum: 30, message: "workout name too long"}
end
