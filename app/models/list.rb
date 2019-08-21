class List < ApplicationRecord
  has_many :join_list_to_movies, -> { order("join_list_to_movies.order desc") }, dependent: :destroy
  has_many :movies, through: :join_list_to_movies

  def random_collage
    movies.sample(4).map(&:poster)
  end
end
