class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin_or_moderator!

  layout "admin"

  private

  # Allow both admin and moderator to access admin section
  def authorize_admin_or_moderator!
    unless current_user&.admin? || current_user&.moderator?
      redirect_to root_path, alert: "You are not authorized to access this section."
    end
  end

  # Restrict some actions only to admins (call with before_action explicitly)
  def authorize_admin_only!
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
