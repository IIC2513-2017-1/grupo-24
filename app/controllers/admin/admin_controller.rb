module Admin
  class AdminController < ApplicationController
    layout 'admin/application'
    before_filter :verify_admin
    private
    def verify_admin
      unless current_user.admin
        flash[:error] = "No tiene permisos para acceder a esta página."
        redirect_to root_path
      end
    end
  end
end
