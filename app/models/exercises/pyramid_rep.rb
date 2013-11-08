class PyramidRep < Exercise
  hstore_accessor :data, :direction, :start_rep, :delta_rep, :delta_weight
  validates :start_rep, presence: {message: "need a starting rep number" }, numericality: { only_integer: true, greater_than: 0, message: "starting rep: only whole, positive numbers" }
  validates :delta_rep, presence: {message: "a rep change amount is needed" }, numericality: { only_integer: true, greater_than: 0, message: "rep change amount: only whole, positive numbers" }
  validates :delta_weight, presence: {message: "a weight change amount is needed" }, numericality: { greater_than: 0, message: "weight change amount: only positive numbers" }
  after_create :create_lift_details

  def routine
    if ascending?
      format_for_display(build_ascending_routine)
    elsif descending?
      format_for_display(build_descending_routine)
    end
  end

  def ascending?
    direction == "ascending"
  end

  def descending?
    direction == "descending"
  end

  def start_routine
    [[start_rep.to_i, initial_weight.to_i]]
  end

  def build_ascending_routine
    routine = start_routine
    (sets-1).times do |num|
      routine << [ (routine[num][0] + delta_rep.to_i), (routine[num][1] - delta_weight.to_i) ]
    end
    routine
  end

  def build_descending_routine
    routine = start_routine
    (sets-1).times do |num|
      routine << [ (routine[num][0] - delta_rep.to_i), (routine[num][1] + delta_weight.to_i) ]
    end
    routine
  end

  def format_for_display(array)
    array.map do |pair|
      "#{pair[0]}@#{pair[1]}lbs"
    end.join(" | ")
  end

  def prescribed_lift
    if ascending?
      ascending_prescribed
    elsif descending?
      descending_prescribed
    end
  end

  def ascending_prescribed
    details = {}
    build_ascending_routine.each_with_index do |set, i|
      i += 1
      details["set_#{i}"] = set[0]
    end
    details
  end

  def descending_prescribed
    details = {}
    build_descending_routine.each_with_index do |set, i|
      i += 1
      details["set_#{i}"] = set[0]
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
    if ascending?
      routine = build_ascending_routine
    elsif descending?
      routine = build_descending_routine
    end
    routine.each_with_index do |pair, i|
      i += 1
      LiftDetail.create(exercise_id: id, set: i, reps: pair[0], weight: pair[1] )
    end
  end

end