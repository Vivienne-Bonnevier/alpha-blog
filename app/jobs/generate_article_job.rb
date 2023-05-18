class GenerateArticleJob < ApplicationJob
  queue_as :default

  def perform(*args)
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
