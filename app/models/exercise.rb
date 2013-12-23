class Exercise < ActiveRecord::Base
  belongs_to :workout
  has_many :lift_details, dependent: :destroy
  accepts_nested_attributes_for :lift_details, allow_destroy: true

  validates :name, presence: {message: "an exercise name is required" }
  validates :increase_weight_by, presence: {message: "a weight to increase by is required" }, numericality: { greater_than_or_equal_to: 0, message: "only positive whole numbers" }
  validates :decrease_weight_by, presence: {message: "a weight to decrease by is required" }, numericality: { greater_than_or_equal_to: 0, message: "only positive whole numbers" }
  validates :increase_strategy, presence: {message: "a frequency for how often to increase the weight by is required" }, numericality: { greater_than_or_equal_to: 0, message: "only positive whole numbers"}
  validates :decrease_strategy, presence: {message: "a frequency for how often to decrease the weight by is required" }, numericality: { greater_than_or_equal_to: 0, message: "only positive whole numbers" }

  amoeba do
    enable
  end

  def routine
    if static_sets?
      "#{lift_details.size}x#{lift_details.first.reps}@#{lift_details.first.weight}"
    else
      lift_details.by_set.map do |detail|
        ["#{detail.reps}@#{detail.weight}"]
      end.join(" | ")
    end
  end

  def increase_weight
    lift_details.each do |detail|
      detail.update_attribute :weight, (detail.weight + increase_weight_by)
    end
  end

  def decrease_weight
    lift_details.each do |detail|
      detail.update_attribute :weight, (detail.weight - decrease_weight_by)
    end
  end

  def static_sets?
    static?(:reps) && static?(:weight)
  end

  private

  def static?(attribute)
    fields = lift_details.map(&attribute)
    sample_field = fields.first
    fields.all? {|field| field == sample_field}
  end

end