class MaxLiftsController < ApplicationController
  before_action :validate_max_lifts, only: [:create]

  def new
    @bench_press = StrengthEstimator.new(current_user).bench_press
    @squat       = StrengthEstimator.new(current_user).squat
    @deadlift    = StrengthEstimator.new(current_user).deadlift
  end

  def create
    current_user.update_attribute(:weight, params[:weight]) if params[:weight]
    MaxLift.record(params[:max_lifts], current_user)
    redirect_to summary_user_max_lifts_path(current_user)
  end

  def summary
    @strength_level = StrengthCalculator.new(current_user)
  end

  def retest
    @edit = true
    @bench_press = current_user.max_lifts.where(exercise_name: "bench press").order(created_at: :desc).first.weight
    @squat       = current_user.max_lifts.where(exercise_name: "squat").order(created_at: :desc).first.weight
    @deadlift    = current_user.max_lifts.where(exercise_name: "deadlift").order(created_at: :desc).first.weight
  end

  private

  def validate_max_lifts
    if !valid_exercise_names?
      flash[:error] = "Do not tamper with exercise names, these are not variable"
      redirect_to new_user_max_lift_path(current_user)
      return
    end

    if weights_invalid?
      flash[:error] = "a weight is required for all lifts - only whole positive numbers"
      if params[:edit].present?
        redirect_to retest_user_max_lifts_path(current_user)
      else
        redirect_to new_user_max_lift_path(current_user)
      end
      return
    end
  end

  def weights_invalid?
    weights = params[:max_lifts].values
    weights.any? {|weight| weight.blank? || weight.to_i < 1 }
  end

  def valid_exercise_names?
    names = params[:max_lifts].keys
    names.all? {|name| allowed_names.include?(name)}
  end

  def allowed_names
    ["squat", "bench press", "deadlift"]
  end
end