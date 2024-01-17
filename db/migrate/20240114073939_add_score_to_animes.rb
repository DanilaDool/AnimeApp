class AddScoreToAnimes < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :score, :float
  end
end
