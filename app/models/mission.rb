class Mission < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :teams, through: :assignments
 
  validates :description, presence: true
  validates :title, uniqueness: true
end
