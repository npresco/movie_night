class PollsController < ApplicationController
  def show
    @poll = Poll.find(params[:id])
    @nominations = @poll.nominations
    @vote = current_user.current_vote(current_club) || Vote.new
    @viewing = current_club.current_viewing

    @locked = Time.current > @viewing.datetime - 1.week || Time.current < @viewing.datetime - 2.weeks
  end

  def poll_params
    params.require(:poll).permit()
  end
end
