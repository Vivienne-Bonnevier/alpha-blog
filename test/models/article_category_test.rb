require "test_helper"

class ArticleCategoryTest < ActiveSupport::TestCase

  def setup
    @admin_user = User.create(username: "admin", email: "admin@admin.com", password: "password", admin: true)

    @category1 = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
    
    @article1 = Article.create(title: "First Article", description: "Description of first article.", user: @admin_user)
    @article2 = Article.create(title: "Second Article", description: "Description of second article.", user: @admin_user)
  end

  test "category has article" do
    @category1.articles << @article1
    assert_equal @category1.articles.first, @article1
  end

  test "article has category" do
    @article1.categories << @category1
    assert_equal @article1.categories.first, @category1
  end

  test "article and category relationship works both ways" do
    @category1.articles << @article1
    assert_equal @article1.categories.first, @category1
  end

  test "category has many articles" do
    @category1.articles << @article1
    @category1.articles << @article2
    assert_equal @category1.articles.count, 2
  end

  test "article has many categories" do
    @article1.categories << @category1
    @article1.categories << @category2
    assert_equal @article1.categories.count, 2
  end

end