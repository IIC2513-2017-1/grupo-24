class DonatorMailer < ApplicationMailer
  def confirmation_email(donation)
    @user = donation.user
    @project = donation.project
    mail subject: "You just made a donation to the project #{project.title} for the ammount of #{project.ammount}", to: user
end
