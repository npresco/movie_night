class CreateViewings < ActiveRecord::Migration[6.0]
  def change
    create_table :viewings do |t|
      t.datetime :datetime
      t.references :club, null: false, foreign_key: true

      t.timestamps
    end
  end
end
