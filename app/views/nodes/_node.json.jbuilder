json.set! :id, node.id.to_s
json.extract! node, :chipid, :status, :ip, :ping_at

json.pins node.pins do |pin|
  json.set! :id, pin.id.to_s
  json.extract! pin, :number, :type, :mode
  json.thing do
    if pin.thing
      json.set! :id, pin.thing.id.to_s
      json.extract! pin.thing, :name, :state
      json.actions pin.thing.actions do |action|
        json.extract! action, :id, :name, :value
      end
    else
      json.nil!
    end
  end
end
