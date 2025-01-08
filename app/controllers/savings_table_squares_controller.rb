class SavingsTableSquaresController < ApplicationController

  def toggle_checked
    square = @couple.savings_table
    savings_table = square.savings_table

    # Alterna o estado de "checked" do quadrado
    square.update(checked: !square.checked)

    # Atualiza o valor total marcado na tabela de economia
    total_checked = savings_table.savings_table_squares.where(checked: true).sum(:value)
    savings_table.update(current_value: total_checked)

    # Retorna resposta JSON com o novo estado
    respond_to do |format|
      format.json { render json: { success: true, checked: square.checked, new_total: total_checked } }
    end
  end
end
