class PyramidRep < Exercise
  hstore_accessor :data, :direction, :start_rep, :delta_rep, :delta_weight
  validates :start_rep, presence: {message: "need a starting rep number" }, numericality: { only_integer: true, greater_than: 0, message: "starting rep: only whole, positive numbers" }
  validates :delta_rep, presence: {message: "a rep change amount is needed" }, numericality: { only_integer: true, greater_than: 0, message: "rep change amount: only whole, positive numbers" }
  validates :delta_weight, presence: {message: "a weight change amount is needed" }, numericality: { greater_than: 0, message: "weight change amount: only positive numbers" }

  def routine(weight=current_weight)
    if ascending?
      format_for_display(build_ascending_routine(weight))
    elsif descending?
      format_for_display(build_descending_routine(weight))
    end
  end

  def ascending?
    direction == "ascending"
  end

  def descending?
    direction == "descending"
  end

  def start_routine(weight=current_weight)
    [[start_rep.to_i, weight.to_i]]
  end

  def build_ascending_routine(weight=current_weight)
    routine = start_routine(weight)
    (sets-1).times do |num|
      routine << [ (routine[num][0] + delta_rep.to_i), (routine[num][1] - delta_weight.to_i) ]
    end
    routine
  end

  def build_descending_routine(weight=current_weight)
    routine = start_routine(weight)
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
end