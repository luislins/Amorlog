class EventsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_couple
  
    def index
      @events = @couple.events
    end
  
    def new
      @event = @couple.events.new
    end
  
    def create
      @event = @couple.events.new(event_params)
      if @event.save
        redirect_to couple_events_path(@couple), notice: "Evento criado com sucesso!"
      else
        render :new
      end
    end
  
    private
  
    def set_couple
      @couple = Couple.find_by(slug: params[:couple_slug])
    end
  
    def event_params
      params.require(:event).permit(:title, :description, :date, :event_type)
    end
  end
  