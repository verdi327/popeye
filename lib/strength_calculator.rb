class StrengthCalculator
  attr_reader :bench_press, :deadlift, :squat, :user

  def initialize(user)
    @user        = user
    @bench_press = user.max_lifts.where(exercise_name: "bench press").order(created_at: :desc).first
    @squat       = user.max_lifts.where(exercise_name: "squat").order(created_at: :desc).first
    @deadlift    = user.max_lifts.where(exercise_name: "deadlift").order(created_at: :desc).first
  end

  def bench_press_ratio
    @bpr ||= bench_press.weight / user.weight
  end

  def squat_ratio
    @sr ||= squat.weight / user.weight
  end

  def deadlift_ratio
    @dr ||= deadlift.weight / user.weight
  end

  def bench_press_percentile
    user.male? ? bench_press_percentile_male : bench_press_percentile_female
  end

  def squat_percentile
    user.male? ? squat_percentile_male : squat_percentile_female
  end

  def deadlift_percentile
    user.male? ? deadlift_percentile_male : deadlift_percentile_female
  end

  def overall
    num = (average(bench_press_percentile) + average(squat_percentile) + average(deadlift_percentile)) / 3
    "#{num}th"
  end

  private

  def average(percentile)
    percentile.gsub(/th/, "").split("-").map(&:to_i).sum / 2
  end

  def bench_press_percentile_male
    if bench_press_ratio >= 2.0
      "95th-100th"
    elsif bench_press_ratio >= 1.75
      "90th-95th"
    elsif bench_press_ratio >= 1.5
      "85th-90th"
    elsif bench_press_ratio >= 1.25
      "80th-85th"
    elsif bench_press_ratio >= 1.0
      "70th-80th"
    elsif bench_press_ratio >= 0.75
      "50th-70th"
    elsif bench_press_ratio >= 0.5
      "40th-50th"
    elsif bench_press_ratio >= 0.25
      "30th-40th"
    else
      "0-30th"
    end
  end

  def squat_percentile_male
    if squat_ratio >= 3.0
      "95th-100th"
    elsif squat_ratio >= 2.5
      "90th-95th"
    elsif squat_ratio >= 2.0
      "85th-90th"
    elsif squat_ratio >= 1.75
      "80th-85th"
    elsif squat_ratio >= 1.5
      "70th-80th"
    elsif squat_ratio >= 1.0
      "50th-70th"
    elsif squat_ratio >= 0.75
      "40th-50th"
    elsif squat_ratio >= 0.5
      "30th-40th"
    else
      "0-30th"
    end
  end

  def deadlift_percentile_male
    if deadlift_ratio >= 3.0
      "95th-100th"
    elsif deadlift_ratio >= 2.5
      "90th-95th"
    elsif deadlift_ratio >= 2.0
      "85th-90th"
    elsif deadlift_ratio >= 1.75
      "80th-85th"
    elsif deadlift_ratio >= 1.5
      "70th-80th"
    elsif deadlift_ratio >= 1.0
      "50th-70th"
    elsif deadlift_ratio >= 0.75
      "40th-50th"
    elsif deadlift_ratio >= 0.5
      "30th-40th"
    else
      "0-30th"
    end
  end

  def bench_press_percentile_female
    if bench_press_ratio >= 1.25
      "95th-100th"
    elsif bench_press_ratio >= 1.0
      "90th-95th"
    elsif bench_press_ratio >= 0.75
      "85th-90th"
    elsif bench_press_ratio >= 0.6
      "80th-85th"
    elsif bench_press_ratio >= 0.5
      "70th-80th"
    elsif bench_press_ratio >= 0.4
      "50th-70th"
    elsif bench_press_ratio >= 0.3
      "40th-50th"
    elsif bench_press_ratio >= 0.25
      "30th-40th"
    else
      "0-30th"
    end
  end

  def squat_percentile_female
    if squat_ratio >= 2.5
      "95th-100th"
    elsif squat_ratio >= 2.0
      "90th-95th"
    elsif squat_ratio >= 1.5
      "85th-90th"
    elsif squat_ratio >= 1.0
      "80th-85th"
    elsif squat_ratio >= 0.75
      "70th-80th"
    elsif squat_ratio >= 0.5
      "50th-70th"
    elsif squat_ratio >= 0.4
      "40th-50th"
    elsif squat_ratio >= 0.3
      "30th-40th"
    else
      "0-30th"
    end
  end

  def deadlift_percentile_female
    if deadlift_ratio >= 2.5
      "95th-100th"
    elsif deadlift_ratio >= 2.0
      "90th-95th"
    elsif deadlift_ratio >= 1.5
      "85th-90th"
    elsif deadlift_ratio >= 1.0
      "80th-85th"
    elsif deadlift_ratio >= 0.75
      "70th-80th"
    elsif deadlift_ratio >= 0.5
      "50th-70th"
    elsif deadlift_ratio >= 0.4
      "40th-50th"
    elsif deadlift_ratio >= 0.3
      "30th-40th"
    else
      "0-30th"
    end
  end
end