class MoviesController < ApplicationController
  def autocomplete_search
    # if params[:query]
    #   @people = Person.search(params[:query])
    # else
    #   @people = Person.all
    # end
    #
    # render partial: "shared/autocomplete_search", locals: { records: @people }
  end

  def index
    if params[:query].present?
      @movies = ::Omdb.search(params[:query])

      @pagy, @movies = pagy_array(@movies)
      @query = params[:query]
      @no_result = true if @movies.empty?
    else
      @movies = Movie.none

      @pagy, @movies = pagy(@movies)
    end
  end

  # For the side quickview
  def show
    @movie = Movie.find(params[:id])

    unless @movie.omdb_checked_date && 6.months.since(@movie.omdb_checked_date) < Date.current
      # Omdb request for movie info and update
      Omdb.info(@movie)
    end

    @movie.reload

    render :show, layout: false
  end
end
