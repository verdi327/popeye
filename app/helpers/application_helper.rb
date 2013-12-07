module ApplicationHelper
  def formatted_date(object)
    date = object.created_at
    date.strftime("%a, %b #{date.day.ordinalize} %Y")
  end

  def button_styling(result)
    result.success? ? "btn-success" : "btn-danger"
  end
end
