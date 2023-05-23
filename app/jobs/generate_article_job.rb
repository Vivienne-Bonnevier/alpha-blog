class GenerateArticleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    article = Article.new
    article.title = Faker::Book.title
    article.description = Faker::Quotes::Shakespeare.hamlet_quote
    article.user = User.find(User.pluck(:id).sample)
    article.save
    rand(0..5).times do
      category = Category.find(Category.pluck(:id).sample)
      unless article.categories.where(name: category.name).exists?
        article.categories << category
        article.save
      end
    end
  end
end
      category = Category.find(Category.pluck(:id).sample)
      unless article.categories.exists?(category.id)
        article.categories << category
        article.save
      end
    end
  end
end
