module WorkoutResultsHelper
  def button_styling(result)
    #both exercise_result and workout_result respond to the success? method
    result.success? ? "btn-success" : "btn-danger"
  end

  def status(workout_result)
    workout_result.success? ? "Move On Up" : "Try Again"
  end

  def formatted_date(workout_result)
    date = workout_result.created_at
    date.strftime("%a, %b #{date.day.ordinalize} %Y")
  end

  def status_icon(exercise_result)
    exercise_result.success? ? "<span class='icon-thumbs-up'></span>" : "<span class='icon-thumbs-down'></span>"
  end
end
