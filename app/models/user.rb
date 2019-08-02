class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :watchlists, dependent: :destroy
  has_many :movies, through: :watchlists

  has_many :club_users
  has_many :clubs, through: :club_users
end
