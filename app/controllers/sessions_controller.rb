class SessionsController < ApplicationController

  # Login
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to user
    else
      # flash.now works when you do not redirect ie rendering the same form page
      flash.now[:alert] = "There was something wrong with your login details."
      render "new"
    end
  end

  # Logout
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged Out"
    redirect_to root_path
  end

end