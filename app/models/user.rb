class User < ApplicationRecord
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  has_many :items, dependent: :destroy
  has_many :bids, dependent: :destroy

  has_secure_password

  def error
    return 'This email is already registered.' if User.find_by(email: email)

    return 'Passwords must match.' if password != password_confirmation

    return 'Complete all fields.' if !email || !password || !first_name || !last_name

    'Something went wrong. Please double check your email and password and try again.'
  end
end
