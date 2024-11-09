class CouplesController < ApplicationController
    def show
      @couple = Couple.find_by(slug: params[:slug])
    end
  
    def new
      @couple = Couple.new
    end
  
    def create
      @couple = Couple.new(couple_params)
      @couple.slug = @couple.name.parameterize
  
      if @couple.save
        redirect_to couple_path(@couple.slug), notice: "Casal criado com sucesso!"
      else
        render :new
      end
    end
  
    private
  
    def couple_params
      params.require(:couple).permit(:name)
    end
  end
  