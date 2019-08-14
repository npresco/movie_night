class ViewingsController < ApplicationController
  def create
    @viewing = Viewing.new(viewing_params)

    if @viewing.save
      redirect_to root_path
    else
      render :new
    end
  end

  def viewing_params
    params.require(:viewing).permit(:datetime, :club_id)
  end
end
