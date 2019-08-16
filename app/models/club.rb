class Club < ApplicationRecord
  has_many :club_users, dependent: :destroy
  has_many :users, through: :club_users
  has_many :club_requests, dependent: :destroy

  has_many :viewings, dependent: :destroy

  def admins
    club_users.select(&:admin)
  end

  def admin?(user)
    admins.any? { |u| u.id == user.id }
  end

  def requests
    club_requests.where(status: "pending")
  end

  def pending_request?(user)
    requests.any? { |cr| cr.user == user }
  end

  def pending_request(user)
    requests.detect { |cr| cr.user == user }
  end

  def current_viewing
    @_current_viewing ||= viewings.where("datetime > ?", DateTime.current).order(:datetime).limit(1).first
  end

  def current_poll
    current_viewing.try(:poll)
  end
end
