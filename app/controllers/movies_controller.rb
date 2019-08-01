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
      @movies = Movie.search_by_title(params[:query])
    else
      @movies = Movie.all.order(title: :asc)
    end

      @pagy, @movies = pagy(@movies)
  end
end
