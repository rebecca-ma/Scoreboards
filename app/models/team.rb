class Team < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :boards, through: :scores
  has_many :missions, through: :assignments

  validates :name, presence: true
  validates :code, uniqueness: true, allow_blank: true
  validates :image_url, uniqueness: true, allow_blank: true
  validate :pc_validations
  
  # ------ Class Methods ------
  def self.pc
    # Returns an array of all non-npc teams
    Team.where(npc: false).all
  end

  # ------ Instance Methods ------
  def pc?
    !npc
  end

  def pc_validations
    # If the team is non-npc, require that code be non-blank
    unless npc
      if code.blank?
        errors.add(:code, "can't be blank for non-npc teams")
      end
      if image_url.blank?
        errors.add(:image_url, "can't be blank for non-npc teams")
      end
    end
  end
end
