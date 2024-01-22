class AddDurrationStuodiosNextEpisodeToAnimes < ActiveRecord::Migration[7.1]
  def change
    add_column :animes, :next_episode_at, :string
    add_column :animes, :studios, :jsonb, default: {}
    add_column :animes, :videos, :jsonb, default: {}
    add_column :animes, :duration, :integer
    add_column :animes, :description, :string
  end
end
