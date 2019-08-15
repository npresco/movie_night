class Club < ApplicationRecord
  has_many :club_users
  has_many :users, through: :club_users

  has_many :viewings

  def admins
    club_users.select(&:admin)
  end

  def admin?(user)
    admins.any? { |u| u.id == user.id }
  end

  def current_viewing
    @_current_viewing ||= viewings.where("datetime > ?", DateTime.current).order(:datetime).limit(1).first
  end

  def current_poll
    current_viewing.poll
  end
end
