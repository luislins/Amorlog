class SavingsTableSquaresController < ApplicationController
  before_action :set_couple

  def toggle_checked
    square = SavingsTableSquare.find(params[:id])
    savings_table = square.savings_table

    # Alterna o estado de "checked" do quadrado
    square.update(checked: !square.checked)

    # Atualiza o valor total marcado na tabela de economia
    total_checked = savings_table.savings_table_squares.where(checked: true).sum(:value)
    savings_table.update(current_value: total_checked)

    # Responde com Turbo Stream para atualizar os elementos relevantes
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(square, partial: "savings_tables/square", locals: { square: square }),
        ]
      end
      format.html { redirect_to savings_table_path(savings_table), notice: "Estado atualizado!" }
    end
  end

  private

  def set_couple
    @couple = current_user.couple
  end
end
