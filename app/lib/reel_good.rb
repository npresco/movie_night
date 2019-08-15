# require 'watir'
# require 'webdrivers'
#
class ReelGood
#
#   def self.search(query)
#     # Create watir browser
#     b = Watir::Browser.new
#
#     # Goto reelgood
#     b.goto "https://www.reelgood.com/"
#
#     # enter query
#     # TODO only search movies
#     b.text_field(id: "searchbox").wait_until(&:present?).set query
#     b.image(alt: "Search Icon").wait_until(&:present?).click
#
#     # loop over results
#     begin
#       b.div("aria-label" => "grid").links.map { |link| [link.text, link.href] }.each do |movie_title, movie_link|
#         puts movie_title
#         puts movie_link
#         next if Movie.find_by(title: movie_title)
#
#         new_b = Watir::Browser.new
#
#         new_b.goto movie_link
#         new_b.span(text: "Embed").wait_until(:present?).click
#         new_b.button(text: "Create Embed").wait_until(:present?).click
#         movie_embed = new_b.code.text
#
#         # create or update local movie resource with title and embed
#         movie = Movie.create_or_find_by(title: movie_title)
#         movie.update_attribute(:embed, movie_embed)
#         new_b.close
#       end
#     rescue Watir::Exception::UnknownObjectException => e
#       puts e
#     ensure
#       b.close
#     end
#   end
end
