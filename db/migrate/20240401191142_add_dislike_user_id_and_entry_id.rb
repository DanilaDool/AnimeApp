class AddDislikeUserIdAndEntryId < ActiveRecord::Migration[7.1]
  def change
    add_column :dislikes, :entry_id, :integer
    add_column :dislikes, :user_id, :integer
  end
end
