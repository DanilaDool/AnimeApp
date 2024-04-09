class Dislike < ApplicationRecord
  belongs_to :entry

  validates :user_id, uniqueness: { scope: :entry_id }
end
