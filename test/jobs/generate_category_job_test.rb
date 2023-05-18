require "test_helper"

class GenerateCategoryJobTest < ActiveJob::TestCase

  test "generate categories and see if user count is correct" do
    assert_enqueued_jobs 0
    perform_enqueued_jobs do
      GenerateCategoryJob.perform_later
      GenerateCategoryJob.perform_later
    end
    assert_performed_jobs 2
    assert_enqueued_jobs 0
    assert Category.all.size == 2
  end

end
