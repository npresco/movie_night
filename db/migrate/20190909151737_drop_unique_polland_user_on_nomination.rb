class DropUniquePollandUserOnNomination < ActiveRecord::Migration[6.0]
  def change
    remove_index :nominations, name: "index_nominations_on_poll_id_and_user_id"

    add_index :nominations, [:poll_id, :movie_id], unique: true
  end
end
