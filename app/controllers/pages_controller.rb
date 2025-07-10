class PagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories
    @today_tasks = Task.joins(:category)
                   .where(categories: { user_id: current_user.id })
                   .where(due_date: Time.zone.today)
                   .order(:due_date)
  end
end
