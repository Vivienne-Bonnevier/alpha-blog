require "test_helper"

class GenerateArticleJobTest < ActiveJob::TestCase

  test "generate articles and see if count is correct" do
    perform_enqueued_jobs do
      GenerateUserJob.perform_later
      GenerateUserJob.perform_later
      GenerateUserJob.perform_later
      GenerateCategoryJob.perform_later
      GenerateCategoryJob.perform_later
      GenerateCategoryJob.perform_later
      GenerateCategoryJob.perform_later
      GenerateCategoryJob.perform_later
      GenerateCategoryJob.perform_later
    end
    assert_performed_jobs 9
    assert_enqueued_jobs 0
    perform_enqueued_jobs do
      GenerateArticleJob.perform_later
      GenerateArticleJob.perform_later
    end
    assert_performed_jobs 11
    assert_enqueued_jobs 0
    assert Article.all.size == 2
  end

end
