class TimeRep < Exercise
  hstore_accessor :data, :time
  validates :time, presence: {message: "time is required" }, numericality: { only_integer: true, greater_than: 0, message: "time: only whole, positive numbers" }

  def routine
    "#{sets}x#{reps} in #{time} secs @ #{current_weight}lbs"
  end

  def prescribed_lift
    details = {}
    sets.times do |num|
      num += 1
      details["set_#{num}"] = reps
    end
    details
  end
end