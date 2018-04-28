class Pin
  include Mongoid::Document
  field :number, type: Integer
  field :type, type: Symbol
  field :mode, type: Symbol
  belongs_to :node
  has_one :thing
end
