class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def set_access_token
    header = request.headers["AUTHORIZATION"]
    if /^Bearer\s(?<access_token>[0-9a-f]{32})$/ =~ header
      @access_token = Regexp.last_match[:access_token]
    end
  end
end
