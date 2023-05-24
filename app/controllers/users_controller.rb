class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :index_form]
  # this MUST come before
  before_action :require_user, only: [:edit, :update, :destroy, :index_form]
  before_action :require_same_user, only: [:edit, :update, :destroy, :index_form]
  before_action :require_different_admin, only: [:destroy]

  def index
    filtered = User.where("username ~* ?", "\S*(#{params[:filter]})\S*")
    @pagy, @users = pagy(filtered.order(:id).all, items: 10)
  end

  def show
    @pagy, @articles = pagy(@user.articles.order(:id), items: 4)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.username}, to the Alpha Blog."
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all authored articles deleted"
    redirect_to users_path
  end

  def index_form

  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # ensure a user is themself or an admin before allowing to edit account
  def require_same_user
    # if someone is not the target user and they are also not an admin
    if current_user != @user && !current_user.admin?
      flash[:alert] = "Unauthorized: You may not edit or delete another user's profile."
      redirect_to @user
    end
  end

  # prevent an admin from deleting their own account, thus preventing the scenario where there may not be an admin
  def require_different_admin
    if current_user == @user && current_user.admin?
      flash[:alert] = "Admins may not delete their own accounts. Please contact another admin and they will asist you."
      redirect_to @user
    end
  end

  
end