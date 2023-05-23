class ApplicationController < ActionController::Base
  include Pagy::Backend

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # with the way that Ruby handles true and false (truthy and falsey), isn't this code redundant? Calling current_user would have the same effect
  def logged_in?
    !!current_user
  end

  # 
  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

  # ensure that user is an admin before performing certain actions
  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = "Unauthorized: You do not have administrator privledges."
      redirect_to root_path
    end
  end

end
