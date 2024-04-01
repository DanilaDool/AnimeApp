class LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    if @like.save
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def like_params
    params.require(:like).permit(:entry_id, :user_id) # Убедитесь, что здесь правильно указаны параметры
  end
end
