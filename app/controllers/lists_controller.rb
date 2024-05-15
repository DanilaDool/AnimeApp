class ListsController < ApplicationController
  before_action :current_user # Если вы используете Devise или подобное, чтобы аутентифицировать пользователя

  def index
    @lists = current_user.lists
  end

  def create
    @list = current_user.list.build(list_params) # Здесь создается список, привязанный к текущему пользователю

    if @list.save
      redirect_to request.referrer, notice: "List created successfully"
    else
      redirect_to request.referrer, alert: "Error creating list"
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
