module BasicAuthHelper
  def basic_auth(user)
    @env ||= {}
    @env['Authorization'] = ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password)
  end
end

module BasicAuth
  def basic_auth(user)
    { Autorization: ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password) }
  end
end

RSpec.configure do |config|
  config.include BasicAuthHelper, type: :request
  config.include BasicAuth, type: :controller
end
