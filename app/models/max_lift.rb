class MaxLift < ActiveRecord::Base
  belongs_to :user

  validates :exercise_name, presence: {message: "Do not tamper with exercise names, these are not variable"}
  validates :weight, presence: {message: "a weight is needed"}, numericality: { only_integer: true, greater_than: 0, message: "only whole positive numbers" }

  def self.record(lift_data, user)
    lift_data.each do |name, weight|
      create(exercise_name: name, weight: weight.to_i, user_id: user.id)
    end
  end
end
