class Poll < ApplicationRecord
  belongs_to :viewing
  has_many :votes, dependent: :destroy
  has_many :nominations, dependent: :destroy

  # Nomination lock is 2 weeks before viewing
  # Vote lockis 1 week before viewing
end
