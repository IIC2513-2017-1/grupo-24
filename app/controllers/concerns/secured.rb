# frozen_string_literal: true

##
# Module for securing controllers access
module Secured
  extend ActiveSupport::Concern

  ##
  # Verify if current_user is logged_in
  def logged_in?
    redirect_to(root_path, alert: 'Acceso restringido') unless current_user
  end

  def is_admin?
    redirect_to(root_path, alert: 'Acceso restringido') unless current_user && current_user.admin
  end
end
