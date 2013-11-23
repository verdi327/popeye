class TimeRep < Exercise
  hstore_accessor :data, :time
  validates :time, presence: {message: "time is required" }, numericality: { only_integer: true, greater_than: 0, message: "time: only whole, positive numbers" }
  after_save :create_lift_details

  def routine(weight=current_weight)
    "#{sets}x#{reps} in #{time} secs @ #{weight}lbs"
  end

  private

  def create_lift_details
    destroy_lift_details
    sets.times do |set|
      set += 1
      LiftDetail.create(exercise_id: id, set: set, reps: reps, weight: calculate_current_weight )
    end
  end

end