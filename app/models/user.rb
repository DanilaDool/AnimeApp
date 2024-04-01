class User < ApplicationRecord
  has_many :entries
  has_many :likes, through: :entries
  has_many :dislikes, through: :entries
end
