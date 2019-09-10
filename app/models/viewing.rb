class Viewing < ApplicationRecord
  after_save :add_poll

  belongs_to :club
  has_one :poll, dependent: :destroy

  validates :datetime, presence: true

  def movie
    poll.movie
  end

  def winning_nominator
    poll.winning_nominator.try(:name)
  end

  def add_poll
    create_poll
  end
end
