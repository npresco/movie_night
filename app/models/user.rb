class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :watchlists, dependent: :destroy
  has_many :movies, through: :watchlists

  has_many :club_users, dependent: :destroy
  has_many :clubs, through: :club_users
  has_many :club_requests, dependent: :destroy

  has_many :nominations, dependent: :destroy
  has_many :votes, dependent: :destroy

  def default_club
    clubs.first
  end

  def requests
    club_requests.where(status: "pending")
  end

  def pending_request?(club)
    requests.any? { |cr| cr.club == club }
  end

  def pending_request(club)
    requests.detect { |cr| cr.club == club }
  end

  def current_nomination(poll_id)
    nominations.where(poll_id: poll_id).limit(1).first
  end

  def current_vote(poll_id)
    votes.where(poll_id: poll_id).limit(1).first
  end
end
