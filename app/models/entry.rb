class Entry < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  validates :content, length: {maximum: 10000}
end
