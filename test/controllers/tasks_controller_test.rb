require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
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

  test "should show task" do
    get category_task_path(@category, @task)
    assert_response :success
  end

  test "should get new" do
    get new_category_task_path(@category)
    assert_response :success
  end

  test "should create task" do
    assert_difference("Task.count") do
      post category_tasks_path(@category), params: {
        task: {
          task_name: "New Task",
          description: "Something",
          due_date: Date.today,
          completed: false
        }
      }
    end
    assert_redirected_to category_path(@category)
  end

  test "should get edit" do
    get edit_category_task_path(@category, @task)
    assert_response :success
  end

  test "should update task" do
    patch category_task_path(@category, @task), params: {
      task: { task_name: "Updated Task" }
    }
    assert_redirected_to category_task_path(@category, @task)
    @task.reload
    assert_equal "Updated Task", @task.task_name
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete category_task_path(@category, @task)
    end
    assert_redirected_to category_path(@category)
  end
end