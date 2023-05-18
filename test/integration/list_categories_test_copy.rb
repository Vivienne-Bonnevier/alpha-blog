require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @categories = []
    2.times do
      category = GenerateCategoryJob
      @categories << category
    end
  end

  test "show categories listing" do
    get "/categories"
    @categories.each do |category|
      assert_select "a[href=?]", category_path(category), text: category.name
    end
  end

  # test "ensure proper pagination of 5 per page" do
    
  #   get "/categories"
  #   # should find all
  #   assert_select "a[href=?]", category_path(@category1), text: @category1.name
  #   assert_select "a[href=?]", category_path(@category2), text: @category2.name
  #   assert_select "a[href=?]", category_path(@category3), text: @category3.name
  #   assert_select "a[href=?]", category_path(@category4), text: @category4.name
  #   assert_select "a[href=?]", category_path(@category5), text: @category5.name
  #   # should NOT find (padgination)
  #   assert_select "a[href=?]", category_path(@category6), false, text: @category6.name
  # end
end
