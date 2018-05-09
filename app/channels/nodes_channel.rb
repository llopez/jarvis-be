class NodesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'nodes_channel'
    send_nodes
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def load_things
    send_nodes
  end

  def remove_thing(data)
    thing = Thing.find(data['id'])
    if thing.destroy
      ActionCable.server.broadcast(
        'nodes_channel',
        type: 'REMOVE_THING',
        payload: JSON.parse(
          ThingsController.render(
            partial: 'thing',
            object: thing
          )
        )
      )
    end
  end

  def update_thing(data)
    thing = Thing.find(data['id'])
    thing.update(data.slice('state'))
    ActionCable.server.broadcast(
      'nodes_channel',
      type: 'UPDATE_THING',
      payload: JSON.parse(
        ThingsController.render(
          partial: 'thing',
          object: thing
        )
      )
    )
  end

  private

  def send_nodes
    ActionCable.server.broadcast(
      'nodes_channel',
      type: 'LOAD_THINGS',
      payload: JSON.parse(
        ThingsController.render(
          partial: 'index',
          locals: {
            things: Thing.all
          }
        )
      )
    )
  end
end
