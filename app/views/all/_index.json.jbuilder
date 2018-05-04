json.nodes do
  json.array! nodes, partial: 'nodes/node', as: :node
end
json.things do
  json.array! things, partial: 'things/thing', as: :thing
end
