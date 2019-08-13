class PollsController < ApplicationController
  def show
    @poll = Poll.find(params[:id])
    @nominations = @poll.nominations
    @vote = current_user.current_vote || Vote.new
    @viewing = current_user.current_viewing

    if @viewing.datetime - 1.week < Time.current
      @locked = true
    end
  end

  def poll_params
    params.require(:poll).permit()
  end
end
