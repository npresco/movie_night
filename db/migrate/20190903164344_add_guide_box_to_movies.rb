class AddGuideBoxToMovies < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :guidebox_checked_date, :date
    add_column :movies, :guidebox_id, :integer
    add_column :movies, :sources, :jsonb, default: "{}"
  end
end
