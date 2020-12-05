class User < ApplicationRecord
  attr_accessor :remember_token

  before_save :downcase_email, :titlecase_name

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" },
    length: { maximum: 100 }, uniqueness: { case_sensitive: false }
  validates :name, length: { minimum: 10, maximum: 250 }
  validates :password, length: { minimum: 8 },
    format: { with: /.*[0-9].*/, message: "should contain at least one number" }

  has_secure_password

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = User.new_token
    update(remember_digest: User.digest(remember_token))
  end

  def forget
    update(remember_digest: nil)
  end

  private

  def downcase_email
    email.downcase!
  end

  def titlecase_name
    self.name = name.titlecase
  end
end
