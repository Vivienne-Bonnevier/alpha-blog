require "test_helper"

class GenerateUserJobTest < ActiveJob::TestCase

  test "generate users and see if user count is correct" do
    assert_enqueued_jobs 0
    perform_enqueued_jobs do
      GenerateUserJob.perform_later
      GenerateUserJob.perform_later
    end
    assert_performed_jobs 2
    assert_enqueued_jobs 0
    assert User.all.size == 2
  end

end
