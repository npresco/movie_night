require 'httparty'

class JustWatchApi
  attr_reader :response

  # Only searches on title for now
  def initialize(query)
    @response = HTTParty.get("https://apis.justwatch.com/content/titles/en_US/popular?body={%22page_size%22:5,%22page%22:1,%22query%22:%22#{query}%22,%22content_types%22:[%22show%22,%22movie%22]}")
  end

  def items
    @items ||= @response["items"]
  end
end
