class NominationsController < ApplicationController
  def create

    if current_user.nominations.size >= 5
      flash[:notice] = "You have reached the nomination limit, remove another nomination to keep nominating"

      redirect_to watchlist_path(current_user)
      return
    end

    create_check = false

    @nomination = Nomination.find_or_initialize_by(nomination_params.slice(:poll_id, :movie_id)) { create_check = true }
    movie = Movie.find(nomination_params[:movie_id])

    if create_check
      @nomination.update(user_id: nomination_params[:user_id])
      flash[:notice] = "#{movie.title} nominated for #{current_club.name}"
    else
      flash[:notice] = "#{movie.title} already nominated for #{current_club.name}"
    end

    redirect_to watchlist_path(current_user)
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

  def destroy
    @nomination = Nomination.find(params[:id])
    if @nomination.destroy
      flash[:notice] = "Nomination removed"
      redirect_to watchlist_path(current_user)
    else
      # Couldnt' find
      redirect_to watchlist_path(current_user)
    end
  end

  def nomination_params
    params.require(:nomination).permit(:poll_id, :user_id, :movie_id)
  end
end
