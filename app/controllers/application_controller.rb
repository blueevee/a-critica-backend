class ApplicationController < ActionController::API
  before_action :reset_session_expiration

  private

  def reset_session_expiration
    request.session_options[:renew] = true
  end
end
