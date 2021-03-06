class User < ApplicationRecord
  has_many :chirps, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships
  has_many :followers, through: :passive_relationships

  attr_accessor :remember_token, :activation_token, :reset_token

  before_validation :downcase_email, :titlecase_name, :strip_whitespaces
  before_create :create_activation_digest

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address" },
    uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 8 },
    format: { with: /.*[0-9].*/, message: "should contain at least one number" }, allow_nil: true

  has_secure_password

  self.per_page = 8

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

  def authenticated?(attribute, token)
    digest = __send__("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update(remember_digest: nil)
  end

  def activate
    update_columns(activated: true, activated_at: Time.current)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.current)
  end

  def send_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 15.minutes.ago
  end

  def feed
    part_of_feed = "relationships.follower_id = :id or chirps.user_id = :id"
    Chirp.joins(user: :followers).where(part_of_feed, { id: id })
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

  def downcase_email
    email.downcase!
  end

  def titlecase_name
    self.name = name.titlecase
  end

  def strip_whitespaces
    name.strip!
    email.strip!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
