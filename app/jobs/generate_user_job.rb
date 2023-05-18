class GenerateUserJob < ApplicationJob
  queue_as :default

  def perform(*args)
    user = User.new
    user.username = Faker::Internet.username
    user.email = Faker::Internet.email
    user.password = "p4ss"
    user.save
  end
end
