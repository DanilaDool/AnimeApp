class DeleteScoreToAnimes < ActiveRecord::Migration[7.1]
  def change
    remove_column :animes, :score
  end
end
