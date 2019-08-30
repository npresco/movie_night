class ChangeMoviesTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :movies, :genre, :text
    rename_column :movies, :imdbID, :imdb_id
    add_column :movies, :tmdb_checked_date, :date
  end
end
