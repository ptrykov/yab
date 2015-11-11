class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  attr_reader :current_user

  protected
  def authenticate
    authenticate_or_request_with_http_basic do  |u, p| 
      account = User.find_by(email: u)
      if account
        @current_user = account.authenticate(p)
      end
    end
  end
end
