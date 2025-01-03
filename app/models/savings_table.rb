class SavingsTable < ApplicationRecord
  belongs_to :couple

  validates :total, presence: true, numericality: { greater_than: 0 }
  validates :max_value, presence: true, numericality: { greater_than: 0 }

  # Exemplo de estrutura para o campo `squares`:
  # [{ value: 50, marked: true }, { value: 30, marked: false }]
end
