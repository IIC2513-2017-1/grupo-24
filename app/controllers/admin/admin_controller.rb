module Admin
  class AdminController < ApplicationController
    layout 'admin/application'
    before_filter :verify_admin
    private
    def verify_admin
      unless current_user.admin
        redirect_to authenticated_root_path
        flash[:error] = "No tiene permisos para acceder a esta página."
      end
    end
  end
end
