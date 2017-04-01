class Team < ApplicationRecord
  has_many :users
  has_many :scores

  validates :name, presence: true
  validate :pc_validations
  
  # ------ Class Methods ------
  def self.pc
    # Returns an array of all non-npc teams
    Team.where(npc: false).all
  end

  # ------ Instance Methods ------
  def pc_validations
    # If the team is non-npc, require that code be non-blank
    unless npc
      if code.blank?
        errors.add(:code, "can't be blank for non-npc teams")
      end
    end
  end
end
