class Poll < ApplicationRecord
  belongs_to :viewing
  has_many :votes
  has_many :nominations

  # Nomination lock is 2 weeks before viewing
  # Vote lockis 1 week before viewing
end
