class PollsController < ApplicationController

  def show
    @poll = Poll.find(params[:id])

    if @poll.club != current_club
      redirect_to root_path
    else
      @nominations = @poll.nominations
      @vote = current_user.current_vote(current_club.current_poll) || Vote.new
      @viewing = current_club.current_viewing

      @locked = Time.current > @viewing.datetime - 5.days || Time.current < @viewing.datetime - 2.weeks
    end
  end

  private

  def poll_params
    params.require(:poll).permit()
  end
end
