class DonationsController < ApplicationController

  def index
    @donations = Donation.where(user_id: current_user)
  end
end
