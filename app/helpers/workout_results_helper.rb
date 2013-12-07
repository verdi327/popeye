module WorkoutResultsHelper
  def status(workout_result)
    workout_result.success? ? "Move On Up" : "Try Again"
  end

  def status_icon(exercise_result)
    exercise_result.success? ? "<span class='icon-thumbs-up'></span>" : "<span class='icon-thumbs-down'></span>"
  end
end
