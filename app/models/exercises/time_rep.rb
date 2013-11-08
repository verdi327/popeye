class TimeRep < Exercise
  hstore_accessor :data, :time
  validates :time, presence: {message: "time is required" }, numericality: { only_integer: true, greater_than: 0, message: "time: only whole, positive numbers" }
  after_create :create_lift_detail

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

  private

  def destroy_lift_details
    if lift_details.present?
      lift_details.each(&:destroy)
    end
  end

  def create_lift_details
    destroy_lift_details
    sets.times do |set|
      set += 1
      LiftDetail.create(exercise_id: id, set: set, reps: reps, weight: initial_weight )
    end
  end

end