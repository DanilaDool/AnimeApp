class RemoveColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :animes, :translation_id
    remove_column :animes, :translation_title
    remove_column :animes, :translation_type
    add_column :animes, :translation, :jsonb, default: {}
  end
end
