class MovieTrailersController < ApplicationController
  def show
    movie = Movie.find(params[:id])

    @trailer = movie.trailer
    # unless @movie.omdb_checked_date && 6.months.since(@movie.omdb_checked_date) < Date.current
    #   # Omdb request for movie info and update
    #   Tmdb.info(@movie)
    # end

    render :show, layout: false
  end
end
