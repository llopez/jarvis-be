json.extract! node, :id, :chipid, :status, :ip, :ping_at
json.pins node.pins do |pin|
  json.extract! pin, :id, :number, :type, :mode
  json.thing do
    if pin.thing
      json.extract! pin.thing, :id, :name, :state
      json.actions pin.thing.actions do |action|
        json.extract! action, :id, :name, :value
      end
    else
      json.nil!
    end
  end
end
