class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def authenticate_token
    authenticate_with_http_token do |token|
      @current_user = User.find_by(auth_token: token)
    end
  rescue Mongoid::Errors::DocumentNotFound
    false
  end

  def authenticate
    authenticate_token || render_unauthorized
  end

  def render_unauthorized
    head :unauthorized
  end
end
