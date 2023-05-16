class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # this MUST come before
  before_action :require_user, except: [:show, :index]
  # this MUST come after
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def show

  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to @article
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to @article
    else
      render "edit"
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  
  # used in show, edit. update, and destroy
  # queries the article with a particular ID
  def set_article
    @article = Article.find(params[:id])
  end

  # the allowed params for an article object (the title and description)
  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    # if someone is not the target user and they are also not an admin
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end

end