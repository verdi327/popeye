class ExercisesController < ApplicationController
  def display_specific_attributes
    @id = params["id"]
    case params["type"]
    when "static_rep" then render :static_rep, {layout: false}
    when "pyramid_rep" then render :pyramid_rep, {layout: false}
    when "time_rep" then render :time_rep, {layout: false}
    end
  end
end