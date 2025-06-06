class DashboardsController < ApplicationController
    before_action :authenticate_user!

    def show 
        case current_user.role
            when "admin"
                redirect_to admin_root_path
            when "moderator"
                render "moderator"
            when "agent"
                render "agent"
            when "distributor"
                render "distributor"
            when "investor"
                render "investor"
            else
                render "general_user"
        end
    end

#     def show
#   return redirect_to admin_root_path if current_user.admin?

#   view_name = current_user.role.presence || "general_user"
#   if lookup_context.exists?(view_name, "dashboards", true)
#     render view_name
#   else
#     render "general_user"
#   end
# end

end
