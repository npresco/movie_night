class ListsController < ApplicationController
  def index
    @lists = List.includes(:movies).all
  end

  def show
    @list = List.find(params[:id])
    @movies = @list.movies
  end
end
