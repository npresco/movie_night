class Seenlist < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  scope :liked, -> { where(score: 1) }
  scope :disliked, -> { where(score: 0) }
end
