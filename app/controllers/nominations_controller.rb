class NominationsController < ApplicationController
  def create
    @nomination = Nomination.new(nomination_params)
    movie = Movie.find(nomination_params[:movie_id])

    if @nomination.save

      flash[:notice] = "#{movie.title} nominated for #{current_club.name}"
      redirect_to watchlist_path(current_user)
    else
      render :new
    end
  end

  def update
    @nomination = Nomination.find(params[:id])
    movie = Movie.find(nomination_params[:movie_id])

    if @nomination.update(nomination_params)

      flash[:notice] = "#{movie.title} nominated for #{current_club.name}"
      redirect_to watchlist_path(current_user)
    else
      render :new
    end
  end

  def nomination_params
    params.require(:nomination).permit(:poll_id, :user_id, :movie_id)
  end
end
