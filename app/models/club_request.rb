class ClubRequest < ApplicationRecord
  belongs_to :user
  belongs_to :club

  validates :status, inclusion: { in: ["pending", "approved", "denied"] }
end
