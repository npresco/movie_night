class Movie < ApplicationRecord
  include PgSearch
  has_many :watchlists
  has_many :users, through: :watchlists

  pg_search_scope :search_by_title, against: :title, using: { tsearch: { prefix: true } }

end
