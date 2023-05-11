class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # with the way that Ruby handles true and false (truthy and falsey), isn't this code redundant? Calling current_user would have the same effect
  def logged_in?
    !!current_user
  end

end
