class CouplesController < ApplicationController

  def show
  end

  def update
    if @couple.update(couple_params)
      redirect_to edit_couple_path(@couple), notice: 'Dados do casal atualizados com sucesso.'
    else
      flash.now[:alert] = 'Erro ao atualizar os dados do casal.'
      render :edit
    end
  end

  private

  def couple_params
    params.require(:couple).permit(:name, :partner_1, :partner_2)
  end
end
