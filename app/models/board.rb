class Board < ApplicationRecord
  has_many :scores, dependent: :destroy

  validates :title, presence: true

  def scores_by_rank
    scores.sort{ |a, b| a.rank <=> b.rank }
  end

  def set_ranks
    scores.group_by { |s|
      s.score
    }.sort_by { |k, v|
      -1 * k
    }.each_with_index { |kv, i|
      kv[1].each do |s|
        s.rank = i + 1
      end
    }
  end
end
