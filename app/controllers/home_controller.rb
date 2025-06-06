# app/controllers/home_controller.rb
class HomeController < ApplicationController
  # def index
  #   if user_signed_in?
  #     redirect_to dashboard_path(current_user)
  #   end
  # end


  def index
  if user_signed_in?
    # Authenticated users should see app content 
    # or be redirected to their dashboard (DON'T send to sign-up)
    render :dashboard  # Example
    # OR redirect_to dashboard_path
  else
    # Unauthenticated users go to sign-up 
    redirect_to new_user_registration_path
  end
end
end
