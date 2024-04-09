class DislikesController < ApplicationController

  def create
    @dislike = Dislike.new(dislike_params)
    if @dislike.save
      existing_like = Like.find_by(entry_id: params[:dislike][:entry_id], user_id: params[:dislike][:user_id])
      existing_like.destroy if existing_like
    end
  end

  def destroy
    @dislike = Dislike.find(params[:id])
    if @dislike.destroy
    end
  end

  private

  def dislike_params
    params.require(:dislike).permit(:entry_id, :user_id)
  end

end
