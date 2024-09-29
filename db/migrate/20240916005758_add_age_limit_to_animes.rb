class AddAgeLimitToAnimes < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :age_limit, :integer
  end
end
