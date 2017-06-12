# Preview all emails at http://localhost:3000/rails/mailers/donator_mailer
class DonatorMailerPreview < ActionMailer::Preview
  def confirmation_email
    DonatorMailer.confirmation_email(Donation.last)
  end

  def goal_achieved
    DonatorMailer.goal_achieved(Project.last, User.last)
  end
end
