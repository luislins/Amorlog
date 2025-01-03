class SavingsTablesController < ApplicationController
    def show
      @savings_table = SavingsTable.find_by(couple: params[:couple_slug])
      render json: { status: "success", savings_table: @savings_table }
    end
  
    def update
      @savings_table = SavingsTable.find_by(couple: params[:couple_slug])
      if @savings_table.update(marked_values: params[:marked_values])
        render json: { status: "success", savings_table: @savings_table }
      else
        render json: { status: "error", errors: @savings_table.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
  