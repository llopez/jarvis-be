class Node
  include Mongoid::Document
  field :chipid, type: String
  field :status, type: Symbol, default: :offline
  field :ip, type: String
  field :ping_at, type: DateTime
  has_many :pins
end
