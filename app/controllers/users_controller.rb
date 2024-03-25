class UsersController < ApplicationController

  def show
    @all_user = User.all
    @user = current_user
    @entry = Entry.new
    @entries_user = @user.entries
  end

  private

  def user_params
    params.require(:user).permit(:uid, :name, :email, :image)
  end
end
