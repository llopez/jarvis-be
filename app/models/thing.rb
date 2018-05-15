class Thing
  include Mongoid::Document
  field :name, type: String
  field :state, type: Hash
  belongs_to :pin
  has_many :actions
end
