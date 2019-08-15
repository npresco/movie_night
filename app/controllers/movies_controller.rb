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
      # If searching, make request to reel good for search and create movie and embed for each result
      @movies = ::Omdb.search(params[:query])
      # @movies = Movie.search_by_title(params[:query])

      @pagy, @movies = pagy_array(@movies)
      @no_result = true if @movies.empty?
    else
      @movies = Movie.none

      @pagy, @movies = pagy(@movies)
    end
  end
end
