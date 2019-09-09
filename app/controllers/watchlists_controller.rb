class WatchlistsController < ApplicationController
  def show
    @genres = Genre.all
    @movies = User.find(params[:id]).movies

    # Filters
    if params[:genre].present?
      @movies = @movies.joins(:genres).where(genres: { id: params[:genre] })
    end

    @pagy, @movies = pagy(@movies, items: 24)

    if current_club
      @nomination = current_user.current_nomination(current_club.current_poll)
      @viewing = current_club.current_viewing
    end

    if @viewing
      # TODO always relevant nomination during dev
      @locked = Time.current > @viewing.datetime - 2.weeks
    end
  end

  def create
    @movie = Movie.find(watchlist_params[:movie_id])

    # TODO Background Jobs
    save_omdb_info(@movie)
    save_tmdb_info(@movie)

    @watchlist = Watchlist.new(watchlist_params)

    if @watchlist.save
      flash[:notice] = "#{@movie.title} added to watchlist"
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
  end

  private

  def save_omdb_info(movie)
    unless @movie.omdb_checked_date && 6.months.since(@movie.omdb_checked_date) < Date.current
      Omdb.info(@movie)
    end

  end

  def save_tmdb_info(movie)
    unless @movie.tmdb_checked_date && 6.months.since(@movie.tmdb_checked_date) < Date.current
      TmdbWrapper.info(@movie)
    end
  end

  def watchlist_params
    params.require(:watchlist).permit(:movie_id, :user_id)
  end
end
