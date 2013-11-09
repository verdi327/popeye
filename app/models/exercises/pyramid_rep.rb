class PyramidRep < Exercise
  hstore_accessor :data, :direction, :start_rep, :delta_rep, :delta_weight
  validates :start_rep, presence: {message: "need a starting rep number" }, numericality: { only_integer: true, greater_than: 0, message: "starting rep: only whole, positive numbers" }
  validates :delta_rep, presence: {message: "a rep change amount is needed" }, numericality: { only_integer: true, greater_than: 0, message: "rep change amount: only whole, positive numbers" }
  validates :delta_weight, presence: {message: "a weight change amount is needed" }, numericality: { greater_than: 0, message: "weight change amount: only positive numbers" }
  after_create :create_lift_details

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
    [[start_rep.to_i, weight]]
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

  private

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