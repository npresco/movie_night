class MoviesController < ApplicationController
  def index
    if params[:query].present?
      @movies = ::Omdb.search(params[:query])
      @movies.each do |movie|
        Omdb.info(movie)
        TmdbWrapper.info(movie)
      end


      # Save the current query in session to it can be used during redirect_back
      session[:query] = params[:query].to_s

      @pagy, @movies = pagy_array(@movies)
      @query = params[:query]
      @no_result = true if @movies.empty?
    elsif session[:query].present?
      @movies = ::Omdb.search(session[:query])
      @movies.each do |movie|
        Omdb.info(movie)
        TmdbWrapper.info(movie)
      end

      @pagy, @movies = pagy_array(@movies)
      @query = session[:query]
      @no_result = true if @movies.empty?
    else
      @movies = Movie.none

      @pagy, @movies = pagy(@movies)
    end
  end

  # For the side quickview
  # TODO movie to movie_quickview model
  def show
    @movie = Movie.find(params[:id])

    unless @movie.omdb_checked_date && 6.months.since(@movie.omdb_checked_date) < Date.current
      Omdb.info(@movie)
    end

    unless @movie.tmdb_checked_date && 6.months.since(@movie.tmdb_checked_date) < Date.current
      TmdbWrapper.info(@movie)
    end

    # Guidebox turn off
    # unless @movie.guidebox_checked_date && 1.month.since(@movie.guidebox_checked_date) < Date.current
    #   @sources = Guidebox.sources(@movie)
    # end

    @movie.reload

    render :show, layout: false
  end
end
