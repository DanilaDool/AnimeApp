class AddToAnime < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :id_anime, :string
    add_column :animes, :link, :string
    add_column :animes, :title_orig, :string
    add_column :animes, :other_title, :string
    add_column :animes, :last_season, :integer
    add_column :animes, :last_episode, :integer
    add_column :animes, :episodes_count, :integer
    add_column :animes, :kinopoisk_id, :string
    add_column :animes, :worldart_link, :string
    add_column :animes, :imdb_id, :string
    add_column :animes, :mdl_id, :string
    add_column :animes, :quality, :string
    add_column :animes, :camrip, :boolean
    add_column :animes, :lgbt, :boolean
    add_column :animes, :blocked_countries, :text, array: true, default: []
    add_column :animes, :blocked_seasons, :jsonb, default: {}
    add_column :animes, :screenshots, :text, array: true, default: []
    add_column :animes, :translation_id, :integer
    add_column :animes, :translation_title, :string
    add_column :animes, :translation_type, :string
  end
end
