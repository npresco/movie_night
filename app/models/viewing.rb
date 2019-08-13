class Viewing < ApplicationRecord
  after_save :add_poll

  belongs_to :club
  has_one :poll, dependent: :destroy

  def add_poll
    create_poll
  end
end
