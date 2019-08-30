class TmdbWrapper
  def self.search(query)
  end

  def self.imdb_id(imdb_id)
  end

  def self.info(movie)
    # Tmdb info
    tmdb_response = Tmdb::Find.movie(movie.imdb_id, external_source: "imdb_id").first
    if tmdb_response
      tmdb_response[:genre_ids].each do |genre_id|
        genre = Genre.find_by_tmdb_genre_id(genre_id)
        JoinGenreToMovie.create_or_find_by(genre_id: genre.id, movie_id: movie.id)
      end
      movie.save
    end

    movie.reload
  end
end
