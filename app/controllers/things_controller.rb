class ThingsController < ApplicationController
  def index
    @things = Thing.all
  end

  def show
    @thing = Thing.find params[:id]
  end
end
