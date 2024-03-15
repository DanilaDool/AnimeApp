class AddMinimalAge < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :minimal_age, :integer
  end
end
