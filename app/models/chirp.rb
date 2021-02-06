class Chirp < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {in: 1..140 }

  self.per_page = 5

  scope :order_by_date_desc, -> { order(created_at: :desc) }
end
