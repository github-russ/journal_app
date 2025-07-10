class CategoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = current_user.categories
    @today_tasks = Task
      .where(due_date: Time.zone.today)
      .where(category_id: current_user.categories.select(:id))
      .order(:due_date)
  end

  def show
    @task = @category.tasks.build
    @tasks = @category.tasks
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to pages_index_path, notice: "Successfully Created a new Category."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Category Updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to root_path, status: :see_other, notice: "Successfully deleted a Category."
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:category_name, :description)
  end

  def record_not_found
    redirect_to root_path, alert: "Category not found."
  end
end
