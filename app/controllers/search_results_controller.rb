class SearchResultsController < ApplicationController
  def show
    if params[:query].present? && params[:query].length >= 3
      @results_a = Anime.search_by_title_and_content(params[:query])
    elsif filter_params_present?
      @results_a = Anime.search_by_filter(filter_params)
    else
      @results_a = Anime.all
    end
  end

  private

  def filter_params_present?
    params[:status].present? || params[:date].present? || params[:dtype].present? ||
    params[:genres].present? || params[:rating_mpaa].present?
  end

  def filter_params
    permitted_params = params.permit(:query, :status, :date, :dtype, :rating_mpaa, :genres)

    # Преобразуем строку жанров в массив, если она передана
    if permitted_params[:genres].present?
      permitted_params[:genres] = permitted_params[:genres].split(',').map(&:strip)
    end

    permitted_params
  end


end
