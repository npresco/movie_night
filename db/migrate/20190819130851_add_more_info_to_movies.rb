class AddMoreInfoToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :omdb_checked_date, :date
    add_column :movies, :rated, :string
    add_column :movies, :runtime, :string
    add_column :movies, :plot, :text
    add_column :movies, :language, :string
    add_column :movies, :country, :string
    add_column :movies, :production, :string
    add_column :movies, :awards, :string
    add_column :movies, :genre, :text
    add_column :movies, :director, :string
    add_column :movies, :writer, :string
    add_column :movies, :actors, :text
    add_column :movies, :ratings, :jsonb, default: "{}"
  end
end
