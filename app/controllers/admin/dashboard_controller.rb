class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  # before_action :authorize
  # before_action :set_active_nav
  before_action :ensure_admin!
  def index
    @users = User.all
  end

  private
  def ensure_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
