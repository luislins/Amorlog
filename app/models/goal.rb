class Goal < ApplicationRecord
  belongs_to :couple

  validates :title, presence: true
  validates :due_date, presence: true
  validates :kind, presence: true
  enum kind: {
    numeric: 0,
    percentage: 1,
    boolean: 2
  }

  def mark_as_achieved
    update(achieved: true)
  end
end
