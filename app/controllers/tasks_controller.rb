class TasksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_task, only: %i[show edit update destroy]
  
  def show; end

  def new
    @task = @category.tasks.new
  end

  def create
    @task = @category.tasks.build(task_params)

    if @task.save
      redirect_to @category, notice: "Successfully added a new Task."
    else
      flash[:alert] = "Failed to add a task."
      render 'categories/show', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to category_task_path(@category, @task), notice: "Task updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to category_path(@category), notice: "Task deleted successfully."
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:task_name, :description, :due_date, :completed)
  end

  def record_not_found
    redirect_to @category, alert: "Task not found."
  end
end
