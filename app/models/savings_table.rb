class SavingsTable < ApplicationRecord
  belongs_to :couple

  validates :max_value, presence: true, numericality: { greater_than: 0 }
  validates :max_value_per_square, presence: true, numericality: { greater_than: 0 }

  has_many :savings_table_squares

  after_create :generate_squares
  after_update :generate_squares, if: -> { saved_change_to_attribute?(:max_value) || saved_change_to_attribute?(:max_value_per_square) }

  private

  def generate_squares
    return if max_value.nil? || max_value <= 0 || max_value_per_square.nil? || max_value_per_square <= 0
  
    savings_table_squares.destroy_all
  
    remaining_value = max_value
  
    SavingsTableSquare.transaction do
      while remaining_value > 0
        square_value = [rand(1..max_value_per_square), remaining_value].min
        savings_table_squares.create!(value: square_value)
        remaining_value -= square_value
      end
    end
  end

end
