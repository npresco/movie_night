require 'open-uri'

class Guidebox

  KEY = Rails.application.credentials.guidebox_api_key

  def self.sources(movie)
    # check for guidebox_id
    unless movie.guidebox_id
      response = HTTParty.get("http://api-public.guidebox.com/v2/search?type=movie&field=id&id_type=imdb&query=#{movie.imdb_id}&api_key=#{KEY}")
      movie.update(guidebox_id: response["id"])
    end

    if movie.guidebox_id
      source_response = HTTParty.get("http://api-public.guidebox.com/v2/movies/#{movie.guidebox_id}?api_key=#{KEY}")
      if source_response
        sources = source_response.slice("free_web_sources", "tv_everywhere_web_sources", "subscription_web_sources", "purchase_web_sources")
        movie.update(sources: sources, guidebox_checked_date: Date.current)
      end
    end
  end
end
