class Movie < ApplicationRecord
  include PgSearch
  has_many :watchlists
  has_many :users, through: :watchlists

  has_many :join_list_to_movies
  has_many :movies, through: :join_list_to_movies

  pg_search_scope :search_by_title, against: :title, using: { tsearch: { prefix: true } }


  # TODO Add tmdb_id
  def trailer
    tmdb_id = Tmdb::Find.movie(imdbID, external_source: 'imdb_id').first.id

    if tmdb_id.present?
      trailer = Tmdb::Movie.videos(tmdb_id).detect { |v| v.site == "YouTube" && v.type == "Trailer" }
    else
      nil
    end
  end
end
