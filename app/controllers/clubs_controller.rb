class ClubsController < ApplicationController
  def index
    # TODO Use pagy
    @clubs = Club.all
  end

  def new
  end

  def create
    @club = Club.new(club_params)

    if @club.save
      @club.club_users << ClubUser.create(user_id: current_user.id, admin: true)
      session[:club_id] = current_user.reload.default_club.try(:id).try(:to_s)
      flash[:notice] = "Club created successfully!"
      redirect_to clubs_path
    else
      flash.now.alert = "Oops, couldn't create account.
      \ Please make sure you are using a valid email and password and try again."
      render :new
    end
  end

  def show
    @club = Club.find(params[:id])
    @club_requests = @club.requests
    @viewings = @club.viewings
  end

  def destroy
    Club.find(params[:id]).destroy
    redirect_to clubs_path
  end

  private

  def club_params
    params.require(:club).permit(:name)
  end
end
