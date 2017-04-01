class Score < ApplicationRecord
  attr_accessor :rank

  belongs_to :board
  belongs_to :team

  validates :score, presence: true
end
