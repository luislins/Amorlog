class SavingsTablesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_couple, only: %i[update show]


  def show
    @savings_table = @couple.savings_table
  end

  def update
    @savings_table = @couple.savings_table
  
    if @savings_table.update(savings_table_params)
      respond_to do |format|
        format.html do
          redirect_to couple_savings_table_path(@couple),
                      notice: "Tabela de economias atualizada com sucesso."
        end
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "squares_grid",
              partial: "goals/squares_grid",
              locals: { savings_table: @savings_table }
            ),
            turbo_stream.replace(
              "savings_total",
              partial: "goals/savings_total",
              locals: { savings_table: @savings_table }
            )
          ]
        end
      end
    else
      render :show, status: :unprocessable_entity
    end
  end
  
  
  private

  def set_couple
    @couple = Couple.find_by(slug: params[:couple_slug])
    return unless @couple.nil? || @couple.user != current_user

    redirect_to root_path, alert: 'Acesso não autorizado.'
  end
  
  def savings_table_params
    params.require(:savings_table).permit(:max_value, :max_value_per_square)
  end
end
