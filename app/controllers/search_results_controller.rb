class SearchResultsController < ApplicationController
  def show
    if params[:query].present?
      @results_a = Anime.search_by_title_and_content(params[:query])
    else
      @results_a = Anime.all
    end
  end
end
