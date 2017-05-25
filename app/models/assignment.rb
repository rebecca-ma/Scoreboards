class Assignment < ApplicationRecord
  belongs_to :team
  belongs_to :mission

  validates :start_time, presence: true
end
