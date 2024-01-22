class AddRatingMpaaToAnimes < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :rating_mpaa, :string
  end
end
