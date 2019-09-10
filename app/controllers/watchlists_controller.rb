class WatchlistsController < ApplicationController
  def show
    @genres = Genre.all
    @decades = []
    13.times { |n| @decades << 1900 + (10 * n) }
    @movies = User.find(params[:id]).movies

    # Filters
    if params[:genre].present?
      @movies = @movies.joins(:genres).where(genres: { id: params[:genre] })
    end

    if params[:decade].present?
      beginning_year = params[:decade].to_i
      end_year = params[:decade].to_i + 9

      @movies = @movies.where("CAST(year as INT) >= ? AND CAST(year as INT) <= ?", beginning_year, end_year)
    end

    if params[:sort].present?
      case params[:sort]
      when "alpha_asc"
        @movies = @movies.order(title: :asc)
      when "alpha_desc"
        @movies = @movies.order(title: :desc)
      when "added_asc"
        @movies =  @movies.order("watchlists.created_at ASC")
      when "added_desc"
        @movies =  @movies.order("watchlists.created_at DESC")
      when "year_asc"
        @movies =  @movies.order(year: :asc)
      when "year_desc"
        @movies =  @movies.order(year: :desc)
      end
    end

    @pagy, @movies = pagy(@movies, items: 24)

    if current_club
      @nominations = current_user.current_nominations(current_club.current_poll)
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
