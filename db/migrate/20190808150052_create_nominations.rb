class CreateNominations < ActiveRecord::Migration[6.0]
  def change
    create_table :nominations do |t|

      t.timestamps
    end
  end
end
