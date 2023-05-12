require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "admin", email: "admin@admin.com", password: "password", admin: true)
    sign_in_as(@admin_user)
  end

  test "get the new category form and create the category" do
    get "/categories/new"
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "Sports" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "get the new category form and reject empty category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "" } }
    end
    assert_match "Name can&#39;t be blank", response.body
  end

  test "get the new category form and reject short category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "Ax" } }
    end
    assert_match "Name is too short (minimum is 3 characters)", response.body
  end

  test "get the new category form and reject long category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "a" * 26 } }
    end
    assert_match "Name is too long (maximum is 25 characters)", response.body
  end

  test "get the new category form and reject duplicate category submission" do
    @category = Category.create(name: "Sports")
    get "/categories/new"
    assert_response :success
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: "Sports" } }
    end
    assert_match "Name has already been taken", response.body
  end

end
 