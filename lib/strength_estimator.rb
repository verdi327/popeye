class StrengthEstimator
  attr_reader :user, :weight

  def initialize(user)
    @user = user
    @weight = user.weight
  end

  def bench_press
    (user.male? ? male_bench_press : female_bench_press).to_i
  end

  def squat
    (user.male? ? male_squat : female_squat).to_i
  end

  def deadlift
    (user.male? ? male_deadlift : female_deadlift).to_i
  end

  private

  def male_bench_press
    weight.to_f * 0.75
  end

  def male_squat
    weight.to_f
  end

  def male_deadlift
    weight.to_f * 1.25
  end

  def female_bench_press
    weight.to_f * 0.5
  end

  def female_squat
    weight.to_f * 0.75
  end

  def female_deadlift
    weight.to_f * 0.75
  end
end