class UserMailer < ApplicationMailer
  def new_user_email(user)
    @user = user
    mail subject: "User #{user.full_name} was successfully created.", to: user.email
end
