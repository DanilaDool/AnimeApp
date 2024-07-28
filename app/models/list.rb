class List < ApplicationRecord
  belongs_to :user

  # validates :animes, uniqueness: true

  # validate :unique_shikimori_id

  validates :name, presence: true

  validates :user_id, presence: true

  private

  def unique_shikimori_id
    if Anime.exists?(shikimori_id: shikimori_id)
      errors.add(:shikimori_id, "Это аниме уже есть в данном списке")
    end
  end
end
