class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @entries_user = current_user.entries
    @likes_per_entry = {}

    if @like.save
      existing_dislike = Dislike.find_by(entry_id: params[:like][:entry_id], user_id: params[:like][:user_id])
      existing_dislike.destroy if existing_dislike

      @entries_user.each do |entry|
        @entry_id = entry.id
        @likes_per_entry[entry.id] = entry.likes.count
      end

      respond_to do |format|
        format.turbo_stream do
          if existing_dislike
            puts "Existing dislike found: #{existing_dislike.inspect}"
            turbo_stream.remove("dislike_#{params[:like][:entry_id]}")
          end
          render turbo_stream: turbo_stream.replace('likes', partial: 'likes/like')
        end
      end
    end
  end

  def destroy
    @dislike = Dislke.find(params[:id])
    entry_id = @dislike.entry_id

    if @like.destroy
      # Удаляем противоположную оценку
      opposite_dislike = Dislike.find_by(entry_id: entry_id, user_id: @dislike.user_id)
      opposite_dislike.destroy if opposite_dislike

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('dislikes', partial: 'dislikes/dislike')
        end

      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:entry_id, :user_id)
  end
end
