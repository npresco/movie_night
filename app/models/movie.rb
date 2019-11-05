class Movie < ApplicationRecord
  include PgSearch

  has_many :join_movie_to_users
  has_many :users, through: :join_movie_to_users

  has_many :join_list_to_movies
  has_many :lists, through: :join_list_to_movies

  has_many :join_genre_to_movies
  has_many :genres, through: :join_genre_to_movies

  pg_search_scope :search_by_title, against: :title, using: { tsearch: { prefix: true } }


  # TODO Add tmdb_id
  def trailer
    tmdb_id = Tmdb::Find.movie(imdb_id, external_source: 'imdb_id').first.id

    if tmdb_id.present?
      trailer = Tmdb::Movie.videos(tmdb_id).detect { |v| v.site == "YouTube" && v.type == "Trailer" }
    else
      nil
    end
  end

  def backdrop
    tmdb_id = Tmdb::Find.movie(imdb_id, external_source: 'imdb_id').first.id

    if tmdb_id.present?
      # This is an array of all backdrops, for now just take the first
      backdrop = Tmdb::Movie.backdrops(tmdb_id).first
      "https://image.tmdb.org/t/p/original#{backdrop.file_path}" if backdrop
    else
      nil
    end
  end
end
