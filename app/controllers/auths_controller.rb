class AuthsController < ApplicationController
  def create
    @user = User.find_by email: params[:email]

    if @user&.authenticate(params[:password])
      render status: :ok
    else
      render json: { error: 'email or password invalid' }, status: :unauthorized
    end
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: 'email or password invalid' }, status: :unauthorized
  end
end
