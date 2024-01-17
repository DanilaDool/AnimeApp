class AddShikimoriIdToAnimes < ActiveRecord::Migration[6.0]
  def change
    add_column :animes, :shikimori_id, :integer unless column_exists?(:animes, :shikimori_id)
    add_column :animes, :title, :string unless column_exists?(:animes, :title)
  end
end
