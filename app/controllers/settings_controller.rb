class SettingsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to settings_path, notice: 'Settings updated successfully.'
    else
      render :show, alert: 'Failed to update settings.'
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      redirect_to root_path, notice: 'Account deleted successfully.'
    else
      redirect_to settings_path, alert: 'Failed to delete account.'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end
end
