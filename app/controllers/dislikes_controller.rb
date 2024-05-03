class DislikesController < ApplicationController
  def create
    @dislike = Dislike.new(dislike_params)
    @entries_user = current_user.entries
    @dislikes_per_entry = {}

    if @dislike.save
      existing_like = Like.find_by(entry_id: params[:dislike][:entry_id], user_id: params[:dislike][:user_id])
      existing_like.destroy if existing_like

      @entries_user.each do |entry|
        @entry_id = entry.id
        @dislikes_per_entry[entry.id] = entry.dislikes.count
      end

      respond_to do |format|
        format.turbo_stream do
          if existing_like
            puts "Existing like found: #{existing_like.inspect}"
            turbo_stream.remove("like_#{params[:dislike][:entry_id]}")
          end
          render turbo_stream: turbo_stream.replace('dislikes', partial: 'dislikes/dislike')
        end
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    entry_id = @like.entry_id

    if @like.destroy
      # Удаляем противоположную оценку (лайк)
      opposite_like = Like.find_by(entry_id: entry_id, user_id: @like.user_id)
      opposite_like.destroy if opposite_like

      respond_to do |format|
        format.turbo_stream do
          # Обновляем turbo-фрейм с дизлайками
          render turbo_stream: turbo_stream.replace('likes', partial: 'likes/like')
        end
      end
    end
  end

  private

  def dislike_params
    params.require(:dislike).permit(:entry_id, :user_id)
  end
end
