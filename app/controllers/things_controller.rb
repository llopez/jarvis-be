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
    broadcast(@thing) if @thing.update_attributes(thing_params)
    render :show
  end

  private

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
