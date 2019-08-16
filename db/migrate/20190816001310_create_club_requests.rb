class CreateClubRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :club_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :club, null: false, foreign_key: true
      t.string :status, null: false, default: "pending"

      t.timestamps
    end
  end
end
