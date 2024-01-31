class ApplicationController < ActionController::Base

  helper_method :current_user

  before_action :anime_random_variable


  private

  def anime_random_variable
    @animes = Anime.all
    @anime_random = @animes.sample
    @anime_random_shikimori_id = @anime_random.shikimori_id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
