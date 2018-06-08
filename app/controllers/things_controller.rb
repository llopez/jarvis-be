class ThingsController < ApplicationController
  def index
    @things = Thing.all
  end

  def show
    @thing = Thing.find params[:id]
  end

  def update
    @thing = Thing.find params[:id]
    @thing.update_attributes(thing_params)
    render :show
  end

  private

  def thing_params
    params.permit(:name, state: [:value])
  end
end
