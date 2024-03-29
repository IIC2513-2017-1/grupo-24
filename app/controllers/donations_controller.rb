class DonationsController < ApplicationController
  include Secured

  before_action :logged_in?, only: %i[create]

  def index
    @user = User.find_by(id: params[:user_id])
    @donations = Donation.where(user_id: params[:user_id])
                         .paginate(page: params[:page], per_page: 6)
  end

  def create
    @donation = Donation.new(donation_params)
    respond_to do |format|
      if @donation.save
        flash.now[:notice] = 'Donación realizada con éxito'
        DonatorMailer.confirmation_email(@donation).deliver_later
      else
        flash.now[:error] = 'Hubo un error realizando la donación'
      end
      format.js { render layout: false }
      format.html {head :no_content }
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:project_id, :ammount)
                             .merge(user_id: current_user.id)
  end
end
