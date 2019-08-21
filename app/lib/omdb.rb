require 'open-uri'

class Omdb
  def self.search(query)
    ActiveRecord::Base.logger.silence do
      movies = []
      response = HTTParty.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.omdb_api_key}&s='#{CGI::escape(query)}'&type=movie")
      if response["Response"] == "True"
        body = JSON.parse(response.body)
        movies = []
        body["Search"].each do |movie_hash|
          movie = Movie.create_or_find_by(title: movie_hash["Title"], imdbID: movie_hash["imdbID"])
          poster = movie_hash["Poster"] == "N/A" ? nil : movie_hash["Poster"]
          movie.update!(year: movie_hash["Year"], poster: poster)
          movies << movie
        end
      end
      movies.each(&:reload)
    end
  end

  def self.title_with_year(title, year)
    response = HTTParty.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.omdb_api_key}&t='#{CGI::escape(title)}'&type=movie&y='#{year}'")
    if response["Response"] == "True"
      ActiveRecord::Base.logger.silence do
        movie = Movie.create_or_find_by(title: response["Title"], imdbID: response["imdbID"])
        poster = response["Poster"] == "N/A" ? nil : response["Poster"]
        movie.update!(year: response["Year"], poster: poster)
        movie
      end
    end
  end

  def self.imdbID(imdbID)
    response = HTTParty.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.omdb_api_key}&i=#{CGI::escape(imdbID)}")
    if response["Response"] == "True"
      ActiveRecord::Base.logger.silence do
        movie = Movie.create_or_find_by(title: response["Title"], imdbID: response["imdbID"])
        poster = response["Poster"] == "N/A" ? nil : response["Poster"]
        movie.update!(year: response["Year"], poster: poster)
        movie
      end
    end
  end

  def self.info(movie)
    response = HTTParty.get("http://www.omdbapi.com/?apikey=#{Rails.application.credentials.omdb_api_key}&i=#{movie.imdbID}&type=movie")
    if response["Response"] == "True"
      movie.update(omdb_checked_date: Date.current,
                   rated: response["Rated"],
                   runtime: response["Runtime"],
                   plot: response["Plot"],
                   language: response["Language"],
                   country: response["Country"],
                   production: response["Production"],
                   awards: response["Awards"],
                   genre: response["Genre"],
                   director: response["Director"],
                   writer: response["Writer"],
                   actors: response["Actors"],
                   ratings: response["Ratings"])
    end
    movie.reload
  end
end
