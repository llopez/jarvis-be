json.extract! thing, :id, :name, :state
json.pin do
  json.extract! thing.pin, :id, :number, :type, :mode
end
json.actions thing.actions do |action|
  json.extract! action, :id, :name, :value
end
