class WatchlistsController < ApplicationController
  def index
    @movies = current_user.movies
    @nomination = current_user.current_nomination
    @viewing = current_user.current_viewing
    if @viewing.datetime - 2.weeks < Time.current
      @locked = true
    end
  end

  def create
    @watchlist = Watchlist.new(watchlist_params)

    if @watchlist.save
      flash[:notice] = "Movie added to watchlist"
      redirect_to movies_path
    else
      flash.now.alert = "Could not save movie"
      render :new
    end
  end

  def destroy
    Watchlist.find(params[:id]).destroy
    flash[notice] = "Movie was removed from watchlist"
    redirect_to params[:redirect_to]
  end

  private

  def watchlist_params
    params.require(:watchlist).permit(:movie_id, :user_id)
  end
end
