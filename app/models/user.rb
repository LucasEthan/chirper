class User < ApplicationRecord
  before_save :downcase_email, :titlecase_name

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" },
    length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :name, length: { minimum: 10, maximum: 250 }
  validates :password, length: { minimum: 8 },
    format: { with: /.*[0-9].*/, message: "should contain at least one number" }

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end

  def titlecase_name
    self.name = name.titlecase
  end
end
