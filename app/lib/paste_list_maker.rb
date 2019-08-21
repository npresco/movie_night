# frozen_string_literal: true

require "open-uri"
require "nokogiri"
require "differ"

# Makes Movie Lists from Paste Magazine Website
class PasteListMaker
  LIST_TYPES = {
    sci_fi_100:  {
      urls: %w[ https://www.pastemagazine.com/articles/2018/11/the-100-best-sci-fi-movies-of-all-time.html
                https://www.pastemagazine.com/articles/2018/11/the-100-best-sci-fi-movies-of-all-time.html?p=2
                https://www.pastemagazine.com/articles/2018/11/the-100-best-sci-fi-movies-of-all-time.html?p=3
                https://www.pastemagazine.com/articles/2018/11/the-100-best-sci-fi-movies-of-all-time.html?p=4 ],
      list_name: "Paste 100 Best Sci-fi Movies"
    },
    dystopian_50: {
      urls: %w[ https://www.pastemagazine.com/articles/2019/08/best-dystopian-movies-of-all-time-1.html
                https://www.pastemagazine.com/articles/2019/08/best-dystopian-movies-of-all-time-1.html?p=2 ],
      list_name: "Paste 50 Best Dystopian Movies"
    },
    fifties_100: {
      urls: %w[ https://www.pastemagazine.com/articles/2017/06/the-100-best-films-of-the-1950s.html
                https://www.pastemagazine.com/articles/2017/06/the-100-best-films-of-the-1950s.html?p=2
                https://www.pastemagazine.com/articles/2017/06/the-100-best-films-of-the-1950s.html?p=3
                https://www.pastemagazine.com/articles/2017/06/the-100-best-films-of-the-1950s.html?p=4 ],
      list_name: "Paste 100 Best 1950s Movies"
    },
    french_100: {
      urls: %w[ https://www.pastemagazine.com/articles/2018/02/the-best-french-films-of-all-time.html
                https://www.pastemagazine.com/articles/2018/02/the-best-french-films-of-all-time.html?p=2
                https://www.pastemagazine.com/articles/2018/02/the-best-french-films-of-all-time.html?p=3
                https://www.pastemagazine.com/articles/2018/02/the-best-french-films-of-all-time.html?p=4 ],
      list_name: "Paste 100 Best French Movies"
    },
    comedy_100: {
      urls: %w[ https://www.pastemagazine.com/articles/2018/05/100-best-comedies-of-all-time.html
                https://www.pastemagazine.com/articles/2018/05/100-best-comedies-of-all-time.html?p=2
                https://www.pastemagazine.com/articles/2018/05/100-best-comedies-of-all-time.html?p=3
                https://www.pastemagazine.com/articles/2018/05/100-best-comedies-of-all-time.html?p=4 ],
      list_name: "Paste 100 Best Comedies"
    },
    b_movies_100: {
      urls: %w[ https://www.pastemagazine.com/blogs/lists/2014/05/the-100-best-b-movies-of-all-time.html
                https://www.pastemagazine.com/blogs/lists/2014/05/the-100-best-b-movies-of-all-time.html?p=2
                https://www.pastemagazine.com/blogs/lists/2014/05/the-100-best-b-movies-of-all-time.html?p=3
                https://www.pastemagazine.com/blogs/lists/2014/05/the-100-best-b-movies-of-all-time.html?p=4
                https://www.pastemagazine.com/blogs/lists/2014/05/the-100-best-b-movies-of-all-time.html?p=5
                https://www.pastemagazine.com/blogs/lists/2014/05/the-100-best-b-movies-of-all-time.html?p=6
                https://www.pastemagazine.com/blogs/lists/2014/05/the-100-best-b-movies-of-all-time.html?p=7
                https://www.pastemagazine.com/blogs/lists/2014/05/the-100-best-b-movies-of-all-time.html?p=8
                https://www.pastemagazine.com/blogs/lists/2014/05/the-100-best-b-movies-of-all-time.html?p=9
                https://www.pastemagazine.com/blogs/lists/2014/05/the-100-best-b-movies-of-all-time.html?p=10 ],
      list_name: "Paste 100 Best 'B-Movies'"
    },
    anime_100: {
      urls: %w[ https://www.pastemagazine.com/articles/2017/01/the-100-best-anime-movies-of-all-time.html
                https://www.pastemagazine.com/articles/2017/01/the-100-best-anime-movies-of-all-time.html?p=2
                https://www.pastemagazine.com/articles/2017/01/the-100-best-anime-movies-of-all-time.html?p=3
                https://www.pastemagazine.com/articles/2017/01/the-100-best-anime-movies-of-all-time.html?p=4 ],
      list_name: "Paste 100 Best Anime"
    },
    heist_21: {
      urls: %w[ https://www.pastemagazine.com/blogs/lists/2013/04/the-best-heist-movies.html ],
      list_name: "Paste 21 Best Heist Movies"
    },
    eighties_80: {
      urls: %w[ https://www.pastemagazine.com/blogs/lists/2012/10/the-80-best-movies-of-the-1980s.html
                https://www.pastemagazine.com/blogs/lists/2012/10/the-80-best-movies-of-the-1980s.html?p=2
                https://www.pastemagazine.com/blogs/lists/2012/10/the-80-best-movies-of-the-1980s.html?p=3
                https://www.pastemagazine.com/blogs/lists/2012/10/the-80-best-movies-of-the-1980s.html?p=4
                https://www.pastemagazine.com/blogs/lists/2012/10/the-80-best-movies-of-the-1980s.html?p=5
                https://www.pastemagazine.com/blogs/lists/2012/10/the-80-best-movies-of-the-1980s.html?p=6
                https://www.pastemagazine.com/blogs/lists/2012/10/the-80-best-movies-of-the-1980s.html?p=7
                https://www.pastemagazine.com/blogs/lists/2012/10/the-80-best-movies-of-the-1980s.html?p=8 ],
      list_name: "Paste 80 Best Movies of the 80s"
    },
    documentary_100: {
      urls: %w[ https://www.pastemagazine.com/articles/2015/05/the-100-best-documentaries-of-all-time.html
                https://www.pastemagazine.com/articles/2015/05/the-100-best-documentaries-of-all-time.html?p=2
                https://www.pastemagazine.com/articles/2015/05/the-100-best-documentaries-of-all-time.html?p=3
                https://www.pastemagazine.com/articles/2015/05/the-100-best-documentaries-of-all-time.html?p=4
                https://www.pastemagazine.com/articles/2015/05/the-100-best-documentaries-of-all-time.html?p=5
                https://www.pastemagazine.com/articles/2015/05/the-100-best-documentaries-of-all-time.html?p=6
                https://www.pastemagazine.com/articles/2015/05/the-100-best-documentaries-of-all-time.html?p=7
                https://www.pastemagazine.com/articles/2015/05/the-100-best-documentaries-of-all-time.html?p=8
                https://www.pastemagazine.com/articles/2015/05/the-100-best-documentaries-of-all-time.html?p=9
                https://www.pastemagazine.com/articles/2015/05/the-100-best-documentaries-of-all-time.html?p=10 ],
      list_name: "Paste 100 Best Documentaries"
    },
    sports_25: {
      urls: %w[ https://www.pastemagazine.com/blogs/lists/2012/08/the-best-sports-movies.html
                https://www.pastemagazine.com/blogs/lists/2012/08/the-best-sports-movies.html?p=2 ],
      list_name: "Paste 25 Best Sports Movies"
    },
    vampire_100: {
      urls: %w[ https://www.pastemagazine.com/articles/2016/09/the-100-best-vampire-movies.html
                https://www.pastemagazine.com/articles/2016/09/the-100-best-vampire-movies.html?p=2
                https://www.pastemagazine.com/articles/2016/09/the-100-best-vampire-movies.html?p=3
                https://www.pastemagazine.com/articles/2016/09/the-100-best-vampire-movies.html?p=4 ],
      list_name: "Paste 100 Best Vampire Movies"
    },
    nineties_90: {
      urls: %w[ https://www.pastemagazine.com/blogs/lists/2012/07/the-90-best-movies-of-the-1990s.html
                https://www.pastemagazine.com/blogs/lists/2012/07/the-90-best-movies-of-the-1990s.html?p=2
                https://www.pastemagazine.com/blogs/lists/2012/07/the-90-best-movies-of-the-1990s.html?p=3
                https://www.pastemagazine.com/blogs/lists/2012/07/the-90-best-movies-of-the-1990s.html?p=4
                https://www.pastemagazine.com/blogs/lists/2012/07/the-90-best-movies-of-the-1990s.html?p=5
                https://www.pastemagazine.com/blogs/lists/2012/07/the-90-best-movies-of-the-1990s.html?p=6
                https://www.pastemagazine.com/blogs/lists/2012/07/the-90-best-movies-of-the-1990s.html?p=7
                https://www.pastemagazine.com/blogs/lists/2012/07/the-90-best-movies-of-the-1990s.html?p=8
                https://www.pastemagazine.com/blogs/lists/2012/07/the-90-best-movies-of-the-1990s.html?p=9 ],
      list_name: "Paste 90 Best Movies of the Nineties"
    },
    rom_com_100: {
      urls: %w[ https://www.pastemagazine.com/articles/2018/08/the-100-best-romantic-comedies-of-all-time.html
                https://www.pastemagazine.com/articles/2018/08/the-100-best-romantic-comedies-of-all-time.html?p=2
                https://www.pastemagazine.com/articles/2018/08/the-100-best-romantic-comedies-of-all-time.html?p=3
                https://www.pastemagazine.com/articles/2018/08/the-100-best-romantic-comedies-of-all-time.html?p=4 ],
      list_name: "Paste 100 Best Romantic Comedies"
    }
  }.freeze

  def self.make_all
    LIST_TYPES.keys.each do |key|
      make(key)
    end
  end

  def self.make(type)
    urls = LIST_TYPES[type][:urls]

    movies = []
    urls.each do |url|
      doc = Nokogiri::HTML(open(url))
      doc.css(".big").each do |list_item|
        movies << list_item
      end
    end

    movies.each do |movie|
      File.open("app/assets/movie_lists/paste_#{type}.txt", "w+") do |file|
        file.write(movies.join("\n"))
      end
    end
  end

  def self.clean_list(type)
    movies = []
    File.open("app/assets/movie_lists/paste_#{type}.txt", "r+").each do |line|
      # Matches from Omdb title and year lookup
      order, title, movie_record = match_line(line)

      if movie_record
        # If match rewrite line if not do broader search
        original = line.strip 
        current = "#{order}. #{movie_record.title} (#{movie_record.year})"

        Differ.format = :color
        diff = Differ.diff_by_char(current, original)
        puts "===> #{diff}"
        puts "===> Match? y/n"
        selection = gets.chomp

        if selection == "y"
          movies << "#{order} - #{movie_record.title} - #{movie_record.year} - #{movie_record.imdbID}"
        else selection == "n"
          movies << search(title, order, line.strip)
        end

        puts ">>> #{movies.join("\n>>> ")}"
        puts "\n"
      else
        movies << search(title, order, line.strip)
      end
    end

    File.open("app/assets/movie_lists/paste_#{type}_fixed.txt", "w+") do |file|
      file.write(movies.join("\n"))
    end
  end

  def self.import_list(type)
    list = List.create_or_find_by(name: LIST_TYPES[type][:list_name])

    File.open("app/assets/movie_lists/paste_#{type}_fixed.txt", "r+").each do |line|
      order, imdbID = line.match(/(\d+|\d+\.\d+)\s-\s.+(?<=\s-\s)(tt\d+)/).captures
      movie_record = Omdb.imdbID(imdbID)
      JoinListToMovie.create(order: order, movie_id: movie_record.id, list_id: list.id)
    end
  end

  def self.search(title, order, line, ran_already= false)
    movie_records = Omdb.search(title)

    movie_arrays =  movie_records.map do |movie_record|
      [order, movie_record.title, movie_record.year, movie_record.imdbID]
    end
    option_hash = movie_arrays.zip([*"a".."z"]).map(&:reverse).map { |k, v| [k, "#{v.join(' - ')}"] }.to_h

    Differ.format = :color
    puts "===> #{option_hash.map { |k, v| diff = Differ.diff_by_char(v, line.strip); "#{k}: #{diff}" }.join("\n===> ")}"
    puts "===> Select closest match"
    puts "===> Put 0 for no matches"
    selection = gets.chomp

    if selection == "0" && ran_already
      line
    elsif selection == "0"
      puts "===> Try entering a new search term"
      new_term = gets.chomp
      search(new_term, order, line.strip, true)
    else
      option_hash[selection]
    end
  end

  def self.match_line(line)
    # Regex for world of tomorrow
    # elsif (match = movie.text.match(/(?<order>\A\d{1,3})\.\s(?<movie>.+)and(?<movie_2>.+)\s\((?<year>\d+);\s(?<year_2>\d+)\)\z/))

    if (match = line.match(/(?<order>\A\d{1,3})\.\s(?<movie>.+)\s\((?<year>\d+)\)/))
      order, movie_title, year = match.captures

      [order, movie_title, Omdb.title_with_year(movie_title, year)]
    else
      order, movie_title = line.match(/(?<order>\A\d{1,3})\.\s(?<movie>.+)\s/).captures

      [order, movie_title, nil]
    end
  end

end
