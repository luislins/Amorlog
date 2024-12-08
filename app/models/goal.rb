class Goal < ApplicationRecord
  belongs_to :couple
  has_one_attached :image

  validates :title, presence: true
  validates :due_date, presence: true
  validates :kind, presence: true
  validates :current_value, numericality: { greater_than_or_equal_to: 0 }
  validate  :current_value_cannot_exceed_numeric_value

  # validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg'], size: { less_than: 5.megabytes, message: 'deve ter menos de 5MB' }

  enum kind: {
    numeric: 0,
    boolean: 1
  }

  def numeric?
    kind == 'numeric' && numeric_value.present? && current_value.present?
  end

  def mark_as_achieved
    update(achieved: true)
  end

  private

  def current_value_cannot_exceed_numeric_value
    if numeric_value.present? && current_value.present? && current_value > numeric_value
      errors.add(:current_value, "não pode ser maior que o valor da meta (#{numeric_value}).")
    end
  end
end
