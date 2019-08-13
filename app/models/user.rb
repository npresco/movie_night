class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :watchlists, dependent: :destroy
  has_many :movies, through: :watchlists

  has_many :club_users
  has_many :clubs, through: :club_users

  has_many :nominations
  has_many :votes

  def current_viewing
    clubs.first.current_viewing
  end

  def current_poll
    clubs.first.current_poll
  end

  def current_nomination
    nominations.where(poll_id: current_poll.id).limit(1).first
  end

  def current_vote
    votes.where(poll_id: current_poll.id).limit(1).first
  end
end
