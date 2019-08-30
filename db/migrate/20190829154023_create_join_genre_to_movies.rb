class CreateJoinGenreToMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :join_genre_to_movies do |t|
      t.references :genre, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end

    add_index :join_genre_to_movies, [:movie_id, :genre_id], unique: true
  end
end
