class RemoveAnimesListsTable < ActiveRecord::Migration[7.1]
  def change
    if table_exists?(:animes_lists)
      drop_table :animes_lists
    end
  end
end
