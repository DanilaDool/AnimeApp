class AddAiredAndRelesedAt < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :aired_at, :string
    add_column :animes, :released_at, :string
  end
end
