class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  # this user comes from the password controller wher user enters their email address
  def password_reset(user)
    @greeting = "Hi"
    @user = user
    mail to: user.email, subject: "Password Reset"

  end
end
