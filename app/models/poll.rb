class Poll < ApplicationRecord
  belongs_to :viewing
  has_many :votes
end
