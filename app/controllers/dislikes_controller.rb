class DislikesController < ApplicationController

  def create
    @dislike = Dislike.new(dislike_params)
    if @dislike.save
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @dislike = Dislike.find(params[:id])
    if @dislike.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def dislike_params
    params.require(:dislike).permit(:entry_id, :user_id)
  end

end
