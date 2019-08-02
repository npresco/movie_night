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
end
