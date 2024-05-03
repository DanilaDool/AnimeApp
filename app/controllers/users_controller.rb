class UsersController < ApplicationController

  def show
    @all_user = User.all
    @entry = Entry.new
    @user = current_user
    @entries_user = @user.entries
    @entries_user_count = @user.entries.count
    @like = Like.new
    @dislike = Dislike.new
    @likes_received_count = @user.likes.count
    @dislikes_received_count = @user.dislikes.count

    @likes_per_entry = []
    @entries_user.each do |entry|
      @likes_per_entry[entry.id] = entry.likes.count
    end

    @dislikes_per_entry = {}
    @entries_user.each do |entry|
      @entry_id = entry.id
      @dislikes_per_entry[entry.id] = entry.dislikes.count
    end
  end

  private

  def user_params
    params.require(:user).permit(:uid, :name, :email, :image)
  end
end
