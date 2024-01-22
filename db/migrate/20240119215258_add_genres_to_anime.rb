class AddGenresToAnime < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :genres, :text, array: true, default: []
  end
end
