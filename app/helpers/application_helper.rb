module ApplicationHelper
  def formatted_date(object)
    date = object.created_at
    date.strftime("%a, %b #{date.day.ordinalize} %Y")
  end

  # devise helper methods
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
