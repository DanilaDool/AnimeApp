class AddAnimesToLists < ActiveRecord::Migration[7.1]
  def change
    add_column :lists, :animes, :string, array: true, default: []
  end
end
