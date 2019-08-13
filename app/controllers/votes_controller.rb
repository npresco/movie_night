class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)

    if @vote.save
      redirect_to poll_path(vote_params[:poll_id])
    else
      render :new
    end
  end

  def update
    @vote = Vote.find(params[:id])

    if @vote.update(vote_params)
      redirect_to poll_path(vote_params[:poll_id])
    else
      render :new
    end
  end

  def vote_params
    params.require(:vote).permit(:poll_id, :user_id, choices: {})
  end
end
