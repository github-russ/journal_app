require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  self.use_instantiated_fixtures = false
  self.use_transactional_tests = true

  def setup
    @user = User.create!(
      email: "user_#{SecureRandom.hex(4)}@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
  end

   test "should not save category without category_name" do
    category = Category.new(user: @user)  # no category_name
    assert_not category.save, "Saved the category without a category_name"
  end

  test "should save category with category_name" do
    category = Category.new(category_name: "Sample Category", user: @user)
    assert category.save, "Failed to save a valid category"
  end
end