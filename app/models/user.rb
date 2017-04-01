class User < ApplicationRecord
  include Authenticator
  
  belongs_to :team

  validates :name, presence: true, uniqueness: true  
end
