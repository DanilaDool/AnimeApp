class LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    if @like.save
      existing_dislike = Dislike.find_by(entry_id: params[:like][:entry_id], user_id: params[:like][:user_id])
      existing_dislike.destroy if existing_dislike
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
    end
  end

  private

  def like_params
    params.require(:like).permit(:entry_id, :user_id) # Убедитесь, что здесь правильно указаны параметры
  end
end
