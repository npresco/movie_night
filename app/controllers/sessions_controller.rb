class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new
  end

  def create
    user = User.find_by(email: params[:login][:email].downcase)

    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id.to_s
      session[:club_id] = user.default_club.try(:id).try(:to_s)

      redirect_to root_path, notice: 'Successfully logged in!'
    else
      flash.now.alert = "Incorrect email or password, try again."
      render :new
    end
  end

  def update
    return unless current_user

    club = current_user.clubs.detect { |c| c.id == params[:club_id].to_i }
    session[:club_id] = club.id if club

    redirect_back fallback_location: root_path
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end
end
