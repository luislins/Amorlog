class SavingsTable < ApplicationRecord
  belongs_to :couple

  MAX_VALUE = 10000000
  MAX_VALUE_PER_SQUARE = 500
  MIN_VALUE_PER_SQUARE = 5

  validates :max_value, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal: MAX_VALUE }
  validates :max_value_per_square, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal: MAX_VALUE_PER_SQUARE }
  validates :max_value_per_square, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :savings_table_squares, dependent: :destroy
  
  after_create :generate_squares
  after_update :generate_squares, if: -> { saved_change_to_attribute?(:max_value) || saved_change_to_attribute?(:max_value_per_square) }

  private

  def generate_squares
    return if max_value.nil? || max_value <= 0
  
    max_value_per_square = MAX_VALUE_PER_SQUARE
    min_value_per_square = MIN_VALUE_PER_SQUARE
  
    # Apaga todos os quadrados existentes de maneira eficiente
    savings_table_squares.delete_all
  
    remaining_value = max_value
    squares_data = []
  
    # Gera os dados dos quadrados em memória
    while remaining_value > 0
      square_value = [
        rand(min_value_per_square..max_value_per_square), # Valor dentro do intervalo permitido
        remaining_value
      ].min
  
      # Garante que o valor seja pelo menos `min_value_per_square` se o restante for suficiente
      if square_value < min_value_per_square && remaining_value >= min_value_per_square
        square_value = min_value_per_square
      end
  
      squares_data << {
        value: square_value,
        checked: false, # Define um valor padrão para o campo `checked`
        savings_table_id: id, # Inclui o ID da tabela associada
        created_at: Time.current,
        updated_at: Time.current
      }
  
      remaining_value -= square_value
    end
  
    # Realiza uma única inserção em massa
    SavingsTableSquare.insert_all!(squares_data) if squares_data.any?
  end
  

end
