class SavingsTableSquaresController < ApplicationController
    before_action :set_couple, only: %i[toggle_checked]

    def toggle_checked
      # @savings_table = @couple.savings_table
      
      square = SavingsTableSquare.find(params[:id])
      savings_table = square.savings_table
      square.update(checked: !square.checked)
      

      total_checked = square.savings_table.savings_table_squares.where(checked: true).sum(:value)
      savings_table.update(current_value: total_checked)

      respond_to do |format|
        format.json { render json: { success: true, checked: square.checked, new_total: total_checked } }
      end
    end

    private

    def set_couple
      # @couple = Couple.find_by(slug: params[:couple_slug])
      # return unless @couple.nil? || @couple.user != current_user

      # redirect_to root_path, alert: 'Acesso não autorizado.'
    end
  end