class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :poll, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.jsonb :choices, null: false, default: "{}"

      t.timestamps
    end
  end
end
