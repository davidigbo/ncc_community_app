class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @users_count = User.count
    @recent_users = User.order(created_at: :desc).limit(10) 

    @user =User.find(params[:user_id]) if params[:user_id].present?
    @user = User.first

    @users = User.all
  
    @business_profiles_pending = BusinessProfile.pending.count
    @business_profiles_approved = BusinessProfile.approved.count
    @business_profiles_rejected = BusinessProfile.rejected.count
    @feedbacks_count = Feedback.count
    @events_count = Event.count

    @total_registrations = EventRegistration.count
    @registrations_this_month = EventRegistration.where("created_at >= ?", Date.today.beginning_of_month).count
    @registrations_per_event = Event.includes(:event_registrations)
    @registrations_per_day = EventRegistration.group_by_day(:created_at).count
    @registrations_by_location = EventRegistration.group(:location).count
    @registrations_by_profession = EventRegistration.group(:profession).count
  end

  private
  def ensure_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end
end
