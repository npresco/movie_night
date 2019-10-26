class AddJoinMovieToUser < ActiveRecord::Migration[6.0]
  def change
    create_table :join_user_to_movies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
