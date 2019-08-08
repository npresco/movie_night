class Vote < ApplicationRecord
  belongs_to :poll
  belongs_to :user
  belongs_to :movie
end
