class User < ApplicationRecord
  before_save :downcase_email

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" },
    length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :name, length: { minimum: 10, maximum: 250 }

  has_secure_password
  
  private

  def downcase_email
    email.downcase!
  end
end
