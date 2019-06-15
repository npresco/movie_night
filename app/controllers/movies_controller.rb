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
    @movies = Movie.limit(25)
  end
end
