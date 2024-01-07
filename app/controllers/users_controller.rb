class UsersController < ApplicationController

  private

  def user_params
    params.require(:user).permit(:uid, :name, :email)
  end
end
