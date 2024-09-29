class SearchResultsController < ApplicationController
  def show
    if params[:query].present? && params[:query].length >= 3
      @results_a = Anime.search_by_title_and_content(params[:query])
    else
      @results_a = []
    end
  end
end
