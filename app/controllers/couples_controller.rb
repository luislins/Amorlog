class CouplesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_couple, only: [:show, :edit, :update, :destroy]

    def show
      @couple = Couple.find_by(slug: params[:slug])
    end
  
    private
  
    def couple_params
      params.require(:couple).permit(:name)
    end
  end
  