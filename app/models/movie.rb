class Movie < ApplicationRecord
  include PgSearch
  has_many :watchlists
  has_many :users, through: :watchlist

  pg_search_scope :search_by_title, against: :title
end
