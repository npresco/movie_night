class JoinMovieToUsersController < ApplicationController
  def show
    @movies = User.find(params[:id]).movies
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
    @movie = Movie.find(join_movie_to_user_params[:movie_id])

    # TODO Background Jobs
    save_omdb_info(@movie)
    save_tmdb_info(@movie)

    @join_movie_to_user = JoinMovieToUser.new(join_movie_to_user_params)

    if @join_movie_to_user.save
      flash[:notice] = "#{@movie.title} added"
      redirect_back fallback_location: root_path
    else
      flash.now.alert = "Could not save movie"
      render :new
    end
  end

  def update
    @movie = Movie.find(join_movie_to_user_params[:movie_id])

    @join_movie_to_user = JoinMovieToUser.find(params[:id])

    if @join_movie_to_user.update(join_movie_to_user_params)
      flash[:notice] = "#{@movie.title} rating removed"
      redirect_back fallback_location: root_path
    else
      flash.now.alert = "Could not save movie"
      render :new
    end
  end

  def destroy
    JoinMovieToUser.find(params[:id]).destroy
    flash[notice] = "Movie was removed"

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

  def join_movie_to_user_params
    params.require(:join_movie_to_user).permit(:movie_id, :user_id, :score)
  end
end
