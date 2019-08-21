class Movie < ApplicationRecord
  include PgSearch
  has_many :watchlists
  has_many :users, through: :watchlists

  has_many :join_list_to_movies
  has_many :movies, through: :join_list_to_movies

  pg_search_scope :search_by_title, against: :title, using: { tsearch: { prefix: true } }
end
