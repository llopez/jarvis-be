class ThingsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'things_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
