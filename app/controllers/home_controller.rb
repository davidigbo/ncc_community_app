# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    redirect_to new_user_registration_path
  end
end
