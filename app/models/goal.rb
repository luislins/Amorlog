class Goal < ApplicationRecord
  belongs_to :couple

  validates :title, presence: true
  validates :due_date, presence: true

  def mark_as_achieved
    update(achieved: true)
  end
end
