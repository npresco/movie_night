class WatchlistsController < ApplicationController
  def index
    @genres = Genre.all

    @movies = current_user.movies.order(title: :asc)

    # Filters
    if params[:genre].present?
      @movies = @movies.joins(:genres).where(genres: { id: params[:genre] })
    end

    @pagy, @movies = pagy(@movies)

    if current_club
      @nomination = current_user.current_nomination(current_club.current_poll)
      @viewing = current_club.current_viewing
    end

    if @viewing
      @locked = Time.current > @viewing.datetime - 2.weeks
    end
  end

  def show
    @movies = User.find(params[:id]).movies

    if current_club
      @nomination = current_user.current_nomination(current_club.current_poll)
      @viewing = current_club.current_viewing
    end

    if @viewing
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

    # TODO Remove these unused params, session and redirect_back are working instead
    # if params[:redirect_to] == movies_path
      # redirect_to params[:redirect_to] + "?query=#{params[:query]}"
    # else
      # redirect_back fallback_location: root_path
    # end
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
