require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = User.create!(
      email: "user_#{SecureRandom.hex(4)}@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    sign_in @user
    @category = @user.categories.create!(category_name: "Sample Category")
  end

  test "index success" do
    get categories_path
    assert_response :success
  end

  test "create category" do
    assert_difference("Category.count") do
      post categories_path, params: { category: { category_name: "New Cat" } }
    end
    assert_redirected_to pages_index_path
  end

  test "show category" do
    get category_path(@category)
    assert_response :success
  end

  test "update category" do
    patch category_path(@category), params: { category: { category_name: "Updated" } }
    assert_redirected_to category_path(@category)
    @category.reload
    assert_equal "Updated", @category.category_name
  end

  test "destroy category" do
    assert_difference("Category.count", -1) do
      delete category_path(@category)
    end
    assert_redirected_to root_path
  end
end
