class AddImgToAnime < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :anime_img, :string
  end
end
