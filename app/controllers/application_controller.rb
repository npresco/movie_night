# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_site_access
  before_action :authenticate_user
  include Pagy::Backend

  def home
    # Viewing info
    @viewing = current_club.current_viewing if current_club
    @viewings = current_club.viewings if current_club

    # Poll info
    # @poll = current_club.current_poll
    #
    # if @poll.club != current_club
    #   redirect_to root_path
    # else
    #   @nominations = @poll.nominations
    #   @vote = current_user.current_vote(current_club.current_poll) || Vote.new
    #   @viewing = current_club.current_viewing
    #
    #   @locked = Time.current > @viewing.datetime - 4.days || Time.current < @viewing.datetime - 2.weeks
    # end
  end

  def current_user
    @current_user ||= User.includes(:movies).find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    @current_user = nil
  end
  helper_method :current_user

  def current_club
    @current_club ||= Club.find(session[:club_id]) if session[:club_id]
  rescue ActiveRecord::RecordNotFound
    @current_club = nil
  end
  helper_method :current_club

  def authenticate_user
    redirect_to login_path, alert: "You must be logged in to access this page." if current_user.nil?
  end

  # Take down once fail2ban is setup as well as belonging to a "club"
  def authenticate_site_access
    authenticate_or_request_with_http_basic do |u, p|
      u == Rails.application.credentials.http_basic_username &&
        p == Rails.application.credentials.http_basic_password
    end
  end
end
