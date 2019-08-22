class WatchlistsController < ApplicationController
  def index
    @movies = current_user.movies

    if current_club
      @nomination = current_user.current_nomination(current_club.current_poll)
      @viewing = current_club.current_viewing
    end

    if @viewing
      @locked = Time.current > @viewing.datetime - 2.weeks
    end
  end

  def create
    @watchlist = Watchlist.new(watchlist_params)

    if @watchlist.save
      flash[:notice] = "Movie added to watchlist"
      # TODO Remove these params
      # redirect_to movies_url(query: params[:query])
      redirect_back fallback_location: root_path
    else
      flash.now.alert = "Could not save movie"
      render :new
    end
  end

  def destroy
    Watchlist.find(params[:id]).destroy
    flash[notice] = "Movie was removed from watchlist"

    redirect_back fallback_location: root_path

    # TODO Remove these unused params, session and redirect_back are working instead
    # if params[:redirect_to] == movies_path
      # redirect_to params[:redirect_to] + "?query=#{params[:query]}"
    # else
      # redirect_back fallback_location: root_path
    # end
  end

  private

  def watchlist_params
    params.require(:watchlist).permit(:movie_id, :user_id)
  end
end
