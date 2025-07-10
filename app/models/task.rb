class Task < ApplicationRecord
  belongs_to :category

  attribute :due_date, :date

  validates :task_name, presence: true
  validates :due_date, presence: true
  validate :due_date_cannot_be_in_the_past

  private

  def due_date_cannot_be_in_the_past
    return if due_date.blank?

    if due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end
end
