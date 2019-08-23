class UserMailer < ApplicationMailer
  default :from => 'any_from_address@example.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( to: @user.email,
          subject: "Thanks for signing up for our amazing app" )
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
