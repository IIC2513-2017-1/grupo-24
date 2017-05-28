class DonatorMailer < ApplicationMailer
  def confirmation_email(donation)
    @user = donation.user
    @project = donation.project
    @donation = donation
    mail subject: "Confirmación de donación", to: user.email
  end

  def goal_achieved(project, user)
    @user = user
    @project = project
    mail subject: "Meta concretada", to: user.email
  end
end
