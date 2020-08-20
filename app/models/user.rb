class User < ApplicationRecord
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  has_many :items, dependent: :destroy
  has_many :bids, dependent: :destroy

  has_secure_password
end
