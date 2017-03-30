class Score < ApplicationRecord
  belongs_to :board

  validates :team, presence: true
  validates :score, presence: true
end
