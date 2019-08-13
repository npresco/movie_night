class Viewing < ApplicationRecord
  after_save :add_poll

  belongs_to :club
  has_one :poll

  def add_poll
    create_poll
  end
end
