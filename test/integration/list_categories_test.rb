require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category1 = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end

  test "show categories listing" do
    get "/categories"
    assert_select "a[href=?]", category_path(@category1), text: @category1.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end

  test "ensure proper pagination of 5 per page" do
    @category3 = Category.create(name: "Healthcare")
    @category4 = Category.create(name: "Physical Fitness")
    @category5 = Category.create(name: "Streaming")
    @category6 = Category.create(name: "Gaming")
    @category7 = Category.create(name: "Cooking")
    @category8 = Category.create(name: "Gardening")
    @category9 = Category.create(name: "Decorating")
    @category10 = Category.create(name: "Cosplay")
    @category11 = Category.create(name: "Magnets")
    get "/categories"
    # should find all
    assert_select "a[href=?]", category_path(@category1), text: @category1.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
    assert_select "a[href=?]", category_path(@category3), text: @category3.name
    assert_select "a[href=?]", category_path(@category4), text: @category4.name
    assert_select "a[href=?]", category_path(@category5), text: @category5.name
    assert_select "a[href=?]", category_path(@category6), text: @category6.name
    assert_select "a[href=?]", category_path(@category7), text: @category7.name
    assert_select "a[href=?]", category_path(@category8), text: @category8.name
    # should NOT find (padgination)
    assert_select "a[href=?]", category_path(@category9), false, text: @category9.name
    assert_select "a[href=?]", category_path(@category10), false, text: @category10.name
    assert_select "a[href=?]", category_path(@category11), false, text: @category11.name
  end
end
