module Authenticator
  extend ActiveSupport::Concern
  
  included do
    attr_accessor :password

    validates :username, presence: true,
                         uniqueness: true
    validates :password, confirmation: true,
                         presence: true,
                         on: :create

    before_save :encrypt_password
  end

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def match_password(password)
    encrypted_password == BCrypt::Engine.hash_secret(password, salt)
  end

  module ClassMethods
    def authenticate(username, password)
      auth = find_by_username(username)
      if auth && auth.match_password(password)
        auth
      else
        nil
      end
    end
  end
end
