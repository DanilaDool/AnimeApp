class HomeController < ApplicationController
  def index
    @animes = Anime.all
  end
end
