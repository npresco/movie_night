class CreateSeenLists < ActiveRecord::Migration[6.0]
  def change
    create_table :seenlists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
