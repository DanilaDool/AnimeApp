class UsersController < ApplicationController

  def show
    @all_user = User.all
  end

  private

  def user_params
    params.require(:user).permit(:uid, :name, :email, :image)
  end
end
