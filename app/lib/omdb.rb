require 'open-uri'

class Omdb

  KEY = if Rails.env == "production"
          Rails.application.credentials.omdb_api_key_production
        else
          Rails.application.credentials.omdb_api_key
        end

  def self.search(query)
    ActiveRecord::Base.logger.silence do
      movies = []
      response = HTTParty.get("http://www.omdbapi.com/?apikey=#{KEY}&s='#{CGI::escape(query)}'&type=movie")
      if response["Response"] == "True"
        body = JSON.parse(response.body)
        movies = []
        body["Search"].each do |movie_hash|
          movie = Movie.create_or_find_by(title: movie_hash["Title"], imdb_id: movie_hash["imdbID"])
          poster = movie_hash["Poster"] == "N/A" ? nil : movie_hash["Poster"]
          movie.update!(year: movie_hash["Year"], poster: poster)
          movies << movie
        end
      end
      movies.each(&:reload)
    end
  end

  def self.title_with_year(title, year)
    response = HTTParty.get("http://www.omdbapi.com/?apikey=#{KEY}&t='#{CGI::escape(title)}'&type=movie&y='#{year}'")
    if response["Response"] == "True"
      ActiveRecord::Base.logger.silence do
        movie = Movie.create_or_find_by(title: response["Title"], imdb_id: response["imdbID"])
        poster = response["Poster"] == "N/A" ? nil : response["Poster"]
        movie.update!(year: response["Year"], poster: poster)
        movie
      end
    end
  end

  def self.imdb_id(imdb_id)
    response = HTTParty.get("http://www.omdbapi.com/?apikey=#{KEY}&i=#{CGI::escape(imdb_id)}")
    if response["Response"] == "True"
      ActiveRecord::Base.logger.silence do
        movie = Movie.create_or_find_by(title: response["Title"], imdb_id: response["imdbID"])
        poster = response["Poster"] == "N/A" ? nil : response["Poster"]
        movie.update!(year: response["Year"], poster: poster)
        movie
      end
    end
  end

  def self.info(movie)
    response = HTTParty.get("http://www.omdbapi.com/?apikey=#{KEY}&i=#{movie.imdb_id}&type=movie")

    # Omdb info
    if response["Response"] == "True"
      movie.update(omdb_checked_date: Date.current,
                   rated: response["Rated"],
                   runtime: response["Runtime"],
                   plot: response["Plot"],
                   language: response["Language"],
                   country: response["Country"],
                   production: response["Production"],
                   awards: response["Awards"],
                   director: response["Director"],
                   writer: response["Writer"],
                   actors: response["Actors"],
                   ratings: response["Ratings"])
    end

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
