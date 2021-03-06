json.set! :id, thing.id.to_s
json.extract! thing, :name, :state
json.pin do
  json.set! :id, thing.pin.id.to_s
  json.extract! thing.pin, :number, :type, :mode
  json.node do
    json.extract! thing.pin.node, :chipid, :status
  end
end
