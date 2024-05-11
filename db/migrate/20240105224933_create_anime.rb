class CreateAnime < ActiveRecord::Migration[7.1]
  def change
    create_table :animes do |t|

      t.timestamps
    end
  end
end
