class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update]

  def index
    @padg = 8
    @categories = Category.paginate(page: params[:page], per_page: @padg)
    @length = Category.all.size
  end

  def show
    @padg = 4
    @articles = @category.articles.paginate(page: params[:page], per_page: @padg)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to @category
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "The category information was successfully updated"
      redirect_to @category
    else
      render "edit"
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
  
  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = "Unauthorized: You do not have permission to perform that action"
      redirect_to categories_path
    end
  end

end
