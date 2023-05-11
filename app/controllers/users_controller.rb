class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
    # this MUST come before
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]


  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome, #{@user.username}, to the Alpha Blog."
      redirect_to articles_path
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

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  # how to make this less redundant with articles.controller?
  def require_same_user
    if current_user != @user
      flash[:alert] = "Unauthorized: You may not edit or delete another user's profile."
      redirect_to @user
    end
  end

end