namespace :transfer do
  task watchlist: :environment do
    Watchlist.find_each do |w|
      JoinMovieToUser.create(w.slice(:movie_id,
                                     :user_id,
                                     :created_at,
                                     :updated_ad))
    end

    Seenlist.find_each do |w|
      JoinMovieToUser.create(w.slice(:movie_id,
                                     :user_id,
                                     :score,
                                     :created_at,
                                     :updated_ad))
    end
  end
end
