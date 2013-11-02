class StaticRep < Exercise
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

end