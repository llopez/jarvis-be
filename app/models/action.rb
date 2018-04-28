class Action
  include Mongoid::Document
  field :name, type: String
  field :value, type: String
  belongs_to :thing
end
