class WatchlistsController < ApplicationController
  def index
    @movies = current_user.movies
    @nomination = current_user.current_nomination
    @viewing = current_user.current_viewing

    @locked = Time.current > @viewing.datetime - 2.weeks
  end

  def create
    @watchlist = Watchlist.new(watchlist_params)

    if @watchlist.save
      flash[:notice] = "Movie added to watchlist"
      redirect_to movies_url(query: params[:query])
    else
      flash.now.alert = "Could not save movie"
      render :new
    end
  end

  def destroy
    Watchlist.find(params[:id]).destroy
    flash[notice] = "Movie was removed from watchlist"
    if params[:redirect_to] == movies_path
      redirect_to params[:redirect_to] + "?query=#{params[:query]}"
    else
      redirect_to params[:redirect_to]
    end
  end

  private

  def watchlist_params
    params.require(:watchlist).permit(:movie_id, :user_id)
  end
end
