class CouplesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_couple, only: %i[show edit update destroy]

    def show
      @couple = Couple.find_by(slug: params[:slug])
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

    def set_couple
      @couple = Couple.find_by(slug: params[:slug])
  
      return unless @couple.nil? || @couple.user != current_user
  
      redirect_to root_path, alert: 'Acesso não autorizado.'
    end

    def couple_params
      params.require(:couple).permit(:name, :partner_1, :partner_2)
    end
end
