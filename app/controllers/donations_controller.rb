class DonationsController < ApplicationController
  include Secured

  before_action :logged_in?, only: %i[create]

  def index
    @user = User.find_by(id: params[:user_id])
    @donations = Donation.where(user_id: params[:user_id])
  end

  def create
    @donation = Donation.new(donation_params)
    respond_to do |format|
      if current_user && @donation.save
        DonatorMailer.confirmation_email(@donation).deliver_later
        format.html { redirect_to project_path(@donation.project),
                      notice: 'Donación realizada' }
      else
        format.html { redirect_to new_session_path,
                      error: 'Debes autentificarte antes de realizar una donacion' }
      end
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:project_id, :ammount)
                             .merge(user_id: current_user.id)
  end
end
