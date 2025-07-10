require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create!(
      email: "user_#{SecureRandom.hex(4)}@example.com",
      password: "password123",
      password_confirmation: "password123"
    )

    @category = Category.create!(
      category_name: "Test Category",
      user: @user
    )
  end

  test "should not save task without category" do
    task = Task.new(task_name: "Do homework")
    assert_not task.save, "Saved the task without a category"
  end

  test "should save task with task_name and category" do
    task = Task.new(
      task_name: "Write journal entry",
      description: "Write about today’s events",
      due_date: Date.today,
      completed: false,
      category: @category
    )
    assert task.save, "Failed to save a valid task"
  end

  test "should not save task with past due_date" do
  task = Task.new(
    task_name: "Past Due Task",
    due_date: Date.yesterday,
    completed: false,
    category: @category
  )
  task.save
  puts "Errors: #{task.errors.full_messages.join(', ')}"
  assert_not task.persisted?, "Saved the task with a past due_date"
  end

  test "should save task with today or future due_date" do
    task = Task.new(
      task_name: "Future Task",
      due_date: Date.today + 1,
      completed: false,
      category: @category
    )
    assert task.save, "Failed to save a task with valid future due_date"
  end
end
