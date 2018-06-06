class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :email, type: String
  field :password_digest, type: String
  field :auth_token, type: String

  has_secure_password

  before_create do
    self.auth_token = SecureRandom.hex
  end
end
