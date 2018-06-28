class ThingsController < ApplicationController
  before_action :authenticate

  def index
    @things = Thing.all
  end

  def show
    @thing = Thing.find params[:id]
  end

  def update
    @thing = Thing.find params[:id]
    if @thing.update_attributes(thing_params)
      publish(@thing)
      broadcast(@thing)
    end
    render :show
  end

  private

  def publish(thing)
    uri = URI.parse ENV['CLOUDMQTT_URL']

    conn_opts = {
      remote_host: uri.host,
      remote_port: uri.port,
      username: uri.user,
      password: uri.password
    }

    MQTT::Client.connect(conn_opts) do |c|
      c.publish("/node/#{thing.pin.node.chipid}", {
        value: thing.state['value'] == 'on' ? '0x8804B43' : '0x88C0051',
        pin: thing.pin.number,
        type: thing.pin.type == :aircon ? 'ir' : thing.pin.type
      }.to_json)
    end
  end

  # TODO: Replace user_token by other uniq identifier
  def broadcast(thing)
    ActionCable.server.broadcast(
      'things_channel',
      user_token: @current_user.auth_token,
      type: 'ITEM_UPDATED',
      payload: JSON.parse(
        ThingsController.render(
          partial: 'thing',
          object: thing
        )
      )
    )
  end

  def thing_params
    params.permit(:name, state: [:value])
  end
end
