class UserMailer < ApplicationMailer
  default from: ENV["email_user_name"]
  # layout 'mailer'

  def welcome_email(user)
    @user = user
    @url = 'localhost:3000'
    mail(to: @user.email, subject: "Welcome to SSG!")
  end
end
