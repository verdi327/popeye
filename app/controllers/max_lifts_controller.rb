class MaxLiftsController < ApplicationController
  before_action :validate_max_lifts, only: [:create]

  def new
  end

  def create
    MaxLift.record(params[:max_lifts], current_user)
    redirect_to summary_user_max_lifts_path(current_user)
  end

  def summary
    @strength_level = StrengthCalculator.new(current_user)
  end

  private

  def validate_max_lifts
    if !valid_exercise_names?
      flash[:error] = "Do not tamper with exercise names, these are not variable"
      redirect_to new_user_max_lift_path(current_user)
      return
    end

    if weights_invalid?
      flash[:error] = "a weight is required - only whole positive numbers"
      redirect_to new_user_max_lift_path(current_user)
      return
    end
  end

  def weights_invalid?
    weights = params[:max_lifts].values
    weights.any? {|weight| weight.blank? || weight.to_i < 0 }
  end

  def valid_exercise_names?
    names = params[:max_lifts].keys
    names.all? {|name| allowed_names.include?(name)}
  end

  def allowed_names
    ["squat", "bench press", "deadlift"]
  end
end