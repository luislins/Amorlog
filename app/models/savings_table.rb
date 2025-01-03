class SavingsTable < ApplicationRecord
  belongs_to :couple

  validates :max_value, presence: true, numericality: { greater_than: 0 }
  validates :max_value_per_square, presence: true, numericality: { greater_than: 0 }

  has_many :savings_table_squares

  after_create :generate_squares

  private

  def generate_squares
    remaining_value = max_value
  
    while remaining_value > 0
      square_value = [rand(1..max_value_per_square), remaining_value].min
      savings_table_squares.create!(value: square_value)
      remaining_value -= square_value
    end
  end

end
