class RomoveGenresToAnime < ActiveRecord::Migration[7.1]
  def change
    remove_column :animes, :genres
  end
end
