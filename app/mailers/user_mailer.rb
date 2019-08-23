class UserMailer < ApplicationMailer
  default :from => "bot@not_a_real_domain_for_movie_night.com"
  # send a signup email to the user, pass in the user object that   contains the user's email address

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
