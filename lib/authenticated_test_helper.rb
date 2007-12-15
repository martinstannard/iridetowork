module AuthenticatedTestHelper
  # Sets the current rider in the session from the rider fixtures.
  def login_as(rider)
    @request.session[:rider] = rider ? riders(rider).id : nil
  end

  def authorize_as(user)
    @request.env["HTTP_AUTHORIZATION"] = user ? "Basic #{Base64.encode64("#{users(user).login}:test")}" : nil
  end
end