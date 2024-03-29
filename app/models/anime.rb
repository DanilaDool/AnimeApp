class Anime < ApplicationRecord
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
