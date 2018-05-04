class NodesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'nodes_channel'
    send_nodes
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def send_nodes
    ActionCable.server.broadcast(
      'nodes_channel',
      JSON.parse(
        ApplicationController.render(
          partial: 'all/index',
          locals: {
            nodes: Node.all,
            things: Thing.all
          }
        )
      )
    )
  end
end
