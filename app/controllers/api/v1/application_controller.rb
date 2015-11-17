class Api::V1::ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include Pundit
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :check_request_format, :authenticate, except: [:no_route_founded]

  attr_reader :current_user

  def no_route_founded
    render json: { error: 'No route founded', status: '404' }, status: :not_found
  end

  protected

  def self.guest_users_can_view
    skip_before_action :authenticate, only: [:index, :show]
  end

  def self.guest_users_can_view_or_create
    skip_before_action :authenticate, only: [:index, :show, :create]
  end

  def check_request_format
    render nothing: true, status: :not_acceptable unless request.format.symbol == :json
  end

  def authenticate
    authenticate_or_request_with_http_basic do  |u, p| 
      account = User.find_by(email: u)
      if account
        @current_user = account.authenticate(p)
      end
    end
  end

  def user_not_authorized
    render nothing: true, status: :forbidden
  end

  
end
