class Seenlist < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  scope :liked, -> { where(score: 1) }
  scope :disliked, -> { where(score: 0) }
end
