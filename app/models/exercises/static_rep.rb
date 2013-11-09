class StaticRep < Exercise
  after_save :create_lift_details

  def routine(weight=current_weight)
    "#{sets}x#{reps} @ #{weight}lbs"
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