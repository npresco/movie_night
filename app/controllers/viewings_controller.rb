class ViewingsController < ApplicationController
  def create
    @viewing = Viewing.new(viewing_params)

    if @viewing.save
      # TODO created viewing flash
    else
      # TODO failed flash
    end

    redirect_back fallback_location: root_path
  end

  def viewing_params
    params.require(:viewing).permit(:datetime, :club_id)
  end
end
