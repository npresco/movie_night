class ApplicationController < ActionController::Base
  before_action :authenticate_site_access
  before_action :authenticate_user
  include Pagy::Backend

  def home
    # For now just deal with one club
    @club = current_user.clubs.first
    @viewing = @club.current_viewing
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticate_user
    redirect_to login_path, alert: "You must be logged in to access this page." if current_user.nil?
  end

  # Take down once fail2ban is setup as well as belonging to a "club"
  def authenticate_site_access
    # authenticate_or_request_with_http_basic do |u, p|
    #   u == "movie" && p == "night"
    # end
  end
end
