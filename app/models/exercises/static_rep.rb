class StaticRep < Exercise
  def routine(weight=current_weight)
    "#{sets}x#{reps} @ #{weight}lbs"
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