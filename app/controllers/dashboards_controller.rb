class DashboardsController < ApplicationController
    before_action :authenticate_user!

    def show 
        case current_user.role
        when 'admin'
            redirect_to admin_root_path
        when 'agent'
            render "agent"
        else
            render "general_user"
        end
    end
end
