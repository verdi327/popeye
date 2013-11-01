class TimeRep < Exercise
  hstore_accessor :data, :time
  validates :time, presence: {message: "time is required" }, numericality: { only_integer: true, greater_than: 0, message: "time: only whole, positive numbers" }

  def routine
    "#{sets}x#{time} seconds of work"
  end
end