class Poll < ApplicationRecord
  belongs_to :viewing
  belongs_to :movie, optional: true

  has_many :votes, dependent: :destroy
  has_many :nominations, dependent: :destroy

  # Nomination lock is 2 weeks before viewing
  # Vote lockis 1 week before viewing

  def club
    viewing.club
  end

  def self.pick_winners
    # TODO optimized
    Poll.all.select { |p| Time.current > p.viewing.datetime - 1.week }.each(&:pick_winner)
  end

  # TODO save this information to db
  def winning_nominator
    nominations.detect { |nom| nom.movie == movie }.try(:user)
  end

  def winner
    movie || pick_winner
  end

  def pick_winner
    max_votes = tally.values.max
    winners = tally.select { |k, v| v == max_votes }
    winner = winners.to_a.sample(1).to_h
    update(movie_id: winner.keys.first.to_i)
    movie
  end

  def tally
    @_tally ||= votes.
      collect(&:choices).
      reduce({}) do |accum, choice_hash|
      accum.merge(choice_hash) { |k, v1, v2| v1.to_i + v2.to_i }
    end
  end
end
