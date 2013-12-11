class BodyMetricsController < ApplicationController
  before_action :find_user
  before_action :require_weight, only: [:create]

  def new
  end

  def create
    @user.update_attributes(weight: params[:weight].to_i, gender: params[:gender])
    redirect_to new_user_max_lift_path(@user)
  end

  private

  def find_user
    @user = User.find params[:user_id]
  end

  def require_weight
    if params[:weight].blank? || params[:weight].to_i <= 0
      flash[:error] = "Oh no! Weight must be an integer greater than 0"
      redirect_to new_user_body_metric_path(@user)
      return
    end
  end
end