class Goal < ApplicationRecord
  belongs_to :couple

  validates :title, presence: true
  validates :due_date, presence: true
  validates :kind, presence: true
  validates :current_value, numericality: { greater_than_or_equal_to: 0 }

  enum kind: {
    numeric: 0,
    boolean: 1
  }

  def numeric?
    kind == "numeric" && numeric_value.present? && current_value.present?
  end

  def mark_as_achieved
    update(achieved: true)
  end
end
