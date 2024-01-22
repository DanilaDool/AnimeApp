class AnimeController < ApplicationController
  def show
    @animes = Anime.all
    @anime_id = Anime.find_by!(shikimori_id: params[:shikimori_id])
  end
end
