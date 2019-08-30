class Genre < ApplicationRecord
  has_many :join_genre_to_movies
  has_many :movies, through: :join_genre_to_movies
end
