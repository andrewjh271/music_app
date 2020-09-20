class UserMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    @url = activate_users_url(activation_token: user.activation_token)
    mail to: @user.email, subject: 'Please confirm your account'
  end
end
