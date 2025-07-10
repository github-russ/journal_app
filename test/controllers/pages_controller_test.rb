require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create!(
      email: "user_#{SecureRandom.hex(4)}@example.com",
      password: "password123",
      password_confirmation: "password123"
    )
    sign_in @user

    @category = @user.categories.create!(category_name: "Work")

    @task = @category.tasks.create!(
      task_name: "Test Task",
      description: "Details...",
      due_date: Date.today,
      completed: false
    )
  end

  test "should get index" do
    get pages_index_path
    assert_response :success
  end
end
