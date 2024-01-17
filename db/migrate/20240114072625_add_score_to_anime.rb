class AddScoreToAnime < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :score, :integer
    add_column :animes, :dtype, :string
    add_column :animes, :date, :string
    add_column :animes, :status, :string
  end
end
