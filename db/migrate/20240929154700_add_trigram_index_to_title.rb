class AddTrigramIndexToTitle < ActiveRecord::Migration[7.1]
  def change
    add_index :animes, :title, using: :gin, opclass: :gin_trgm_ops
  end
end
