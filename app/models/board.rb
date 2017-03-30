class Board < ApplicationRecord
  has_many :scores, -> { order(score: :desc) }, dependent: :destroy

  validates :title, presence: true

  def get_ranks
    prev_s = 0
    prev_i = 0
    scores.each_with_index { |s, i|
      if s.score == prev_s
        prev_i + 1
      else
        prev_s = s.score
        prev_i = i
        i + 1
      end
    }
  end
end
