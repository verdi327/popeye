class ExercisesController < ApplicationController
  def display_specific_attributes
    @id = params["id"]
    case params["type"]
    when "StaticRep" then render :static_rep, {layout: false}
    when "PyramidRep" then render :pyramid_rep, {layout: false}
    when "TimeRep" then render :time_rep, {layout: false}
    end
  end
end