class AddGenresToAnimes2 < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :genres, :jsonb, default: {}
  end
end
