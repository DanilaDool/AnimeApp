class AddAnAttributeForAnime < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :not_blocked_in, :string
    add_column :animes, :not_blocked_for_me, :boolean
  end
end
