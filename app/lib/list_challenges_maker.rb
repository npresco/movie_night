# frozen_string_literal: true

require "open-uri"
require "nokogiri"
require "differ"

# Makes Movie Lists from Paste Magazine Website
class ListChallengesMaker
  LIST_TYPES = {
    before_you_die_1001:  {
      urls: %w[ https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/2
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/3
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/4
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/4
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/5
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/6
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/7
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/8
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/9
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/10
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/11
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/12
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/13
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/14
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/15
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/16
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/17
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/18
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/19
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/20
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/21
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/22
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/23
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/24
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/25
                https://www.listchallenges.com/1001-movies-to-see-before-you-die-2017-edition/list/26 ],
      list_name: "1001 Movies to See Before You Die"
    },
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
      doc.css(".list-item").map(&:text).map(&:squish).each do |list_item|
        movies << list_item
      end
    end

    movies.each do |movie|
      File.open("app/assets/movie_lists/#{type}.txt", "w+") do |file|
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
          movies << "#{order} - #{movie_record.title} - #{movie_record.year} - #{movie_record.imdb_id}"
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
      order, imdb_id = line.match(/(\d+|\d+\.\d+)\s-\s.+(?<=\s-\s)(tt\d+)/).captures
      movie_record = Omdb.imdb_id(imdb_id)
      JoinListToMovie.create(order: order, movie_id: movie_record.id, list_id: list.id)
    end
  end

  def self.search(title, order, line, ran_already= false)
    movie_records = Omdb.search(title)

    movie_arrays =  movie_records.map do |movie_record|
      [order, movie_record.title, movie_record.year, movie_record.imdb_id]
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
