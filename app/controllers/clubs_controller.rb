class ClubsController < ApplicationController
  def index
    @clubs = current_user.clubs
  end

  def show
    @club = Club.find(params[:id])
  end
end
