class SavingsTablesController < ApplicationController
  before_action :set_savings_table, only: %i[show update]

  def show; end

  def update
    if @savings_table.update(savings_table_params)
      respond_to do |format|
        format.html { redirect_to couple_savings_table_path(@couple), notice: "Tabela de economias atualizada com sucesso." }
        format.turbo_stream { render_updated_savings_table }
      end
    else
      flash[:alert] = @savings_table.errors.full_messages.to_sentence
      redirect_to couple_goals_path(@couple)
    end
  end

  private
  

  def set_savings_table
    @savings_table = @couple.savings_table
  end

  def render_updated_savings_table
    @savings_table.reload

    render turbo_stream: [
      turbo_stream.replace(
        "squares_grid",
        partial: "squares_grid",
        locals: { savings_table: @savings_table }
      ),
      turbo_stream.replace(
        "savings_total",
        partial: "savings_total",
        locals: { savings_table: @savings_table }
      ),
      turbo_stream.replace(
        "savings_table_meter",
        partial: "savings_table_meter",
        locals: { savings_table: @savings_table }
      ),
      turbo_stream.replace(
        "savings_table_resume",
        partial: "savings_table_resume",
        locals: { savings_table: @savings_table }
      )
    ]
  end

  def savings_table_params
    params.require(:savings_table).permit(:max_value)
  end
end
