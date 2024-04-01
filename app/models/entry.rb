class Entry < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :dislikes

  validates :content, length: {maximum: 10000}

  mount_uploader :img_content, ImgContentUploader

  validates :content, presence: true, unless: :image_content?
  
  def image_content?
    img_content.present? && img_content.file.present?
  end
end
