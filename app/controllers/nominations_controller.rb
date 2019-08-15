class NominationsController < ApplicationController
  def create
    @nomination = Nomination.new(nomination_params)

    if @nomination.save
      redirect_to watchlists_path
    else
      render :new
    end
  end

  def update
    @nomination = Nomination.find(params[:id])

    if @nomination.update(nomination_params)
      redirect_to watchlists_path
    else
      render :new
    end
  end

  def nomination_params
    params.require(:nomination).permit(:poll_id, :user_id, :movie_id)
  end
end
