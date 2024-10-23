class Anime < ApplicationRecord

  include PgSearch::Model

  pg_search_scope :search_by_title_and_content,
  against: [:title, :shikimori_id],
  using: {
     tsearch: { prefix: true },
     trigram: { threshold: 0.2 }
  }

  pg_search_scope :search_by_filter,
  against: [:date, :status, :dtype, :genres, :rating_mpaa],
  using: {
    tsearch: { prefix: true },
    trigram: { threshold: 0.1 }
  }

  def self.search_by_filter(filter_params)
    results = Anime.all

    if filter_params[:date].present?
      results = results.where("EXTRACT(YEAR FROM to_date(date, 'YYYY-MM-DD')) = ?", filter_params[:date])
    end

    if filter_params[:status].present?
      results = results.where(status: filter_params[:status])
    end

    if filter_params[:dtype].present?
      results = results.where(dtype: filter_params[:dtype])
    end

    if filter_params[:genres].present?
      # Используем оператор ?| для поиска аниме, содержащих хотя бы один из выбранных жанров
      genres_array = filter_params[:genres] # Это уже массив
      results = results.where("genres ?| array[:genres]", genres: genres_array)
    end

    if filter_params[:rating_mpaa].present?
      results = results.where(rating_mpaa: filter_params[:rating_mpaa].split(' ').map(&:strip))
    end

    if filter_params[:query].present?
      results = results.where("title ILIKE ?", "%#{filter_params[:query]}%")
    end

    results
  end


  def in_current_season?
    current_month = Date.today.month
    current_year = Date.today.year
    target_date = Date.parse(created_at.to_s)
    target_month = target_date.month
    target_year = target_date.year

    current_season = (current_month + 2) % 12 / 3
    target_season = (target_month + 2) % 12 / 3

    current_season == target_season && current_year == target_year
  end
end
