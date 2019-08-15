class CreatePolls < ActiveRecord::Migration[6.0]
  def change
    create_table :polls do |t|
      t.references :viewing, null: false, foreign_key: true
      t.references :movie, null: true, foreign_key: true

      t.timestamps
    end
  end
end
