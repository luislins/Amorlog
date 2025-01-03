class SavingsTablesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_couple, only: %i[update show]


  def show
    @savings_table = @couple.savings_table
  end

  def update
    @savings_table = @couple.savings_table
    if @savings_table.update(savings_table_params)
      redirect_to couple_savings_table_path(@couple), notice: "Tabela de economias atualizada com sucesso."
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
