class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" },
    length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :name, length: { minimum: 10, maximum: 250 }
end
