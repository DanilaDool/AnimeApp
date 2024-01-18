class HomeController < ApplicationController
  def index
    @animes = Anime.all
    @creation_date = Date.new
  end

end
