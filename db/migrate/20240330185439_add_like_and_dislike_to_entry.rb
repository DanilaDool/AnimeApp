class AddLikeAndDislikeToEntry < ActiveRecord::Migration[7.1]
  def change
    add_column :entries, :like, :integer
    add_column :entries, :dislike, :integer
  end
end
