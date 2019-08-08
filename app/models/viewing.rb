class Viewing < ApplicationRecord
  belongs_to :club
  has_one :poll
end
