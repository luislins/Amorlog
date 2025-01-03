class SavingsTable < ApplicationRecord
    belongs_to :couple

    validates :total, presence: true, numericality: { greater_than: 0 }
    validates :max_value, presence: true, numericality: { greater_than: 0 }
  end