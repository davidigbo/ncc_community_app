# app/controllers/home_controller.rb
class HomeController < ApplicationController
  before_action :authenticate_user!
  
def dashboard
  if user_signed_in?
    @latest_events = Event.order(created_at: :desc).limit(5)
    # @popular_events = Event.order(attendees_count: :desc).limit(5)
    @upcoming_events = Event.where("start_date > ?", Time.current).order(start_date: :asc).limit(5)
    @past_events = Event.where("end_date < ?", Time.current).order(end_date: :desc).limit(5)

    render :dashboard
  else
    redirect_to new_user_registration_path
  end
end
end
