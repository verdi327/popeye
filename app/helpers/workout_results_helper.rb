module WorkoutResultsHelper

  def status_icon(exercise_result)
    if exercise_result.status == "increased"
      "<span class='icon-thumbs-up'></span>"
    elsif exercise_result.status == "decreased"
      "<span class='icon-thumbs-down'></span>"
    else
      "<span class='icon-truck'></span>"
    end
  end

  def button_styling(exercise_result)
    if exercise_result.status == "increased"
      "btn-success"
    elsif exercise_result.status == "decreased"
      "btn-danger"
    else
      "btn-default"
    end
  end

  def display_lift(lift_result)
    "<b>Set #{lift_result.set}</b> - #{lift_result.achieved_reps} @ #{lift_result.used_weight}lbs"
  end

end
