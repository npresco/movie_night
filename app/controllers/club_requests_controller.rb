# frozen_string_literal: true

class ClubRequestsController < ApplicationController
  def create
    @club_request = ClubRequest.new(club_params)

    if @club_request.save
      redirect_to clubs_path
    else
      root_path
    end
  end

  def update
    @club_request = ClubRequest.find(params[:id])

    # TODO what to do when denied?
    if club_params[:status] == "approved"
      @club_request.update(club_params)
      @club_request.club.users << @club_request.user
    end

    redirect_to club_path(@club_request.club)
  end

  def destroy
    @club_request = ClubRequest.find(params[:id]).destroy

    redirect_to clubs_path
  end

  private

  def club_params
    params.require(:club_request).permit(:user_id, :club_id, :status)
  end
end
