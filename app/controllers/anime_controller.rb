class AnimeController < ApplicationController
  def show
    @animes = Anime.all
    @anime_id = Anime.find_by!(shikimori_id: params[:shikimori_id])
    @user = current_user

    @list = List.new
  end

  def index
    @animes = Anime.all
  end

  def cult
    @animes = Anime.all
  end
end
