class PyramidRep < Exercise
  hstore_accessor :data, :direction, :starting_rep_number, :delta
  validates :starting_rep_number, presence: {message: "need a starting rep number" }, numericality: { only_integer: true, greater_than: 0, message: "starting rep: only whole, positive numbers" }
  validates :delta, presence: {message: "a change amount is needed" }, numericality: { only_integer: true, greater_than: 0, message: "change amount: only whole, positive numbers" }
end