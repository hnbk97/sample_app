class User < ApplicationRecord
  before_save :downcase_email
  validates :name, presence: true,
    length: {maximum: Settings.user_validates.name_max}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user_validates.email_max},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true
  has_secure_password
  validates :password, presence: true,
  length: {minimum: Settings.user_validates.password_min}

  def downcase_email
    email.downcase!
  end
end
