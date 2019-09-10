class User < ApplicationRecord
  attr_accessor :reset_token
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

  def current_nominations(poll_id)
    @_current_nominations ||= nominations.where(poll_id: poll_id).limit(5)
  end

  def current_vote(poll_id)
    votes.where(poll_id: poll_id).limit(1).first
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
