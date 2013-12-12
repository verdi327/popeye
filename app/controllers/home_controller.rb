class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :check_for_mobile

  def show
  end
end