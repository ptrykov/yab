class Api::V1::ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :check_request_format, :authenticate

  attr_reader :current_user

  protected

  def check_request_format
    render nothing: true, status: 406 unless request.format.symbol == :json
  end

  def authenticate
    authenticate_or_request_with_http_basic do  |u, p| 
      account = User.find_by(email: u)
      if account
        @current_user = account.authenticate(p)
      end
    end
  end
end
