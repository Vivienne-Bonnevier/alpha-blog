class GenerateCategoryJob < ApplicationJob
  queue_as :default

  def perform(*args)
    category = Category.new
    category.name = Faker::Hobby.activity
    category.save
  end
end
