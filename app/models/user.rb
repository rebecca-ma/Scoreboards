class User < ApplicationRecord
  include Authenticator

  attr_accessor :code
  belongs_to :team, optional: true

  validates :name, presence: true, uniqueness: true  
  
  before_validation :find_team_from_code

  # ------ Instance Methods ------
  def find_team_from_code
    if code
      self.team = Team.find_by_code(code)
      unless team
        errors.add(:code, 'is invalid')
      end
    end
  end
end
