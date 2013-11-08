class StaticRep < Exercise
  after_save :create_lift_details

  def routine
    "#{sets}x#{reps} @ #{current_weight}lbs"
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