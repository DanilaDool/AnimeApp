class DropTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :animes, :shikimori
  end
end
