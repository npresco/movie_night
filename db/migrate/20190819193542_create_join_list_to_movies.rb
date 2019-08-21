class CreateJoinListToMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :join_list_to_movies do |t|
      t.references :list, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.float :order

      t.timestamps
    end

    add_index :join_list_to_movies, [:movie_id, :list_id], unique: true
  end
end
