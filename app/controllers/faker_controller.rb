class FakerController < ApplicationController
  before_action :require_admin

  # generate random users
  def user_random
    number = params[:id]
    number.to_i.times do
      GenerateUserJob.perform_later
    end
    redirect_to users_path
  end

  # generate 1 user
  def user_random_1
    user = user_generate
    redirect_to users_path(user)
  end

  # generate random categories
  def category_random
    number = params[:id]
    number.to_i.times do
      GenerateCategoryJob.perform_later
    end
    redirect_to categories_path
  end

  # generate 1 category
  def category_random_1
    category = category_generate
    redirect_to categories_path(category)
  end

  # generate random articles
  def article_random
    number = params[:id]
    number.to_i.times do
      article_generate
    end
    redirect_to articles_path
  end

  # generate 1 article
  def article_random_1
    article = article_generate
    redirect_to articles_path(article)
  end

  # populates users table, articles table, and categories table with relationships between all
  def set_up_random
    25.times do
      user_generate
    end
    20.times do
      category_generate
    end
    50.times do
      article_generate
    end
    redirect_to root_path
  end

  private
  def user_generate
    user = User.new
    user.username = Faker::Internet.username
    user.email = Faker::Internet.email
    user.password = "p4ss"
    user.save
  end

  def category_generate
    category = Category.new
    category.name = Faker::Hobby.activity
    category.save
  end

  def article_generate
    article = Article.new
    article.title = Faker::Book.title
    article.description = Faker::Quotes::Shakespeare.hamlet_quote
    article.user = User.find(User.pluck(:id).sample)
    categories = Category.all.clone.to_a
    category_number = rand(0..5)
    category_number.times do
      category = categories.slice!(rand(0..categories.size-1))
      category = Category.find(category.id)
      article.categories << category
    end
    article.save
  end


end