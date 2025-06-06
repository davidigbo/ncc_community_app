class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @users_count = User.count
    @business_profiles_pending = BusinessProfile.pending.count
    @business_profiles_approved = BusinessProfile.approved.count
    @business_profiles_rejected = BusinessProfile.rejected.count
    @feedbacks_count = Feedback.count
    @events_count = Event.count
  end

  private
  def ensure_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
