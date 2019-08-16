class ApplicationController < ActionController::Base
  before_action :authenticate_site_access
  before_action :authenticate_user
  include Pagy::Backend

  def home
    if current_club
      @viewing = current_club.current_viewing
    end
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      @current_user = nil
    end
  end
  helper_method :current_user

  def current_club
    begin
      @current_club ||= Club.find(session[:club_id]) if session[:club_id]
    rescue ActiveRecord::RecordNotFound
      @current_club = nil
    end
  end
  helper_method :current_club

  def authenticate_user
    redirect_to login_path, alert: "You must be logged in to access this page." if current_user.nil?
  end

  # Take down once fail2ban is setup as well as belonging to a "club"
  def authenticate_site_access
    authenticate_or_request_with_http_basic do |u, p|
      u == "movie" && p == "night"
    end
  end
end
