class AnimeController < ApplicationController
  def show
    @animes = Anime.all
    @anime_id = Anime.find_by!(shikimori_id: params[:shikimori_id])
  end

  def index
    @animes = Anime.all
  end

  def cult
    @animes = Anime.all
  end
end
