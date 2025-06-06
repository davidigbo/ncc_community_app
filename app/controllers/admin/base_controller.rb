class Admin::BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!

    layout "admin"

    private
    def authorize_admin!
        unless current_user && (current_user.admin? || current_user.moderator?)
            redirect_to root_path, alert: "You are not authorized to access this section."
        end
    end
end