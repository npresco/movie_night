require 'open-uri'

class Omdb
  def self.search(query)
    response = HTTParty.get("http://www.omdbapi.com/?apikey=10803757&s='#{query}'&type=movie")
    body = JSON.parse(response.body)
    movies = []
    body["Search"].each do |movie_hash|
      movie = Movie.create_or_find_by(title: movie_hash["Title"])
      poster = movie_hash["Poster"] == "N/A" ? nil : movie_hash["Poster"]
      movie.update!(year: movie_hash["Year"], imdbID: movie_hash["imdbID"], poster: poster)
      movies << movie
    end
    movies
  end

  def self.info(imdbID)
    response = HTTParty.get("http://www.omdbapi.com/?apikey=10803757&i='#{imdbID}'&type=movie")
    body = JSON.parse(response.body)
    movies = []
    body["Search"].each do |movie_hash|
      movie = Movie.create_or_find_by(title: movie_hash["Title"])
      poster = movie_hash["Poster"] == "N/A" ? nil : movie_hash["Poster"]
      movie.update!(year: movie_hash["Year"], imdbID: movie_hash["imdbID"], poster: poster)
      movies << movie
    end
    movies
  end
end
