class GenerateArticleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    article = Article.new
    article.title = Faker::Book.title
    article.description = Faker::Quotes::Shakespeare.hamlet_quote
    article.user = User.find(User.pluck(:id).sample)
    article.save
    rand(0..5).times do
      article.categories << Category.find(Category.pluck(:id).sample)
      article.save
    end
  end
end
