class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome, #{@user.username}, to the Alpha Blog, you have successfully signed up."
      redirect_to articles_path
    else
      render "new"
    end
  end

  def edit
    @user = find_user
  end

  def update
    @user = find_user
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to articles_path
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def find_user
    User.find(params[:id])
  end

end