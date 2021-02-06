class Chirp < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :user_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "must be a valid image format" },
    size: { less_than: 5.megabytes, message: "should be less than 5mb" }

  self.per_page = 5

  scope :order_by_date_desc, -> { order(created_at: :desc) }
end
