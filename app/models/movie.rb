class Movie < ApplicationRecord
  include PgSearch
  has_many :watchlists
  has_many :users, through: :watchlists

  pg_search_scope :search_by_title, against: :title, using: { tsearch: { prefix: true } }

  def poster_or_default
    poster || "https://www.fillmurray.com/200/300"
  end
end
