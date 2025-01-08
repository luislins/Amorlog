class EventsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_event, only: %i[edit update destroy]

  def index
    @events = @couple.events
  end

  def new
    @event = @couple.events.new
  end

  def create
    @event = @couple.events.new(event_params)
    if @event.save
      redirect_to couple_events_path(@couple), notice: 'Evento criado com sucesso!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to couple_events_path(@couple), notice: 'Evento atualizado com sucesso!'
    else
      flash.now[:alert] = 'Erro ao atualizar o evento.'
      render :edit
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(dom_id(@event))
      end
      format.html { redirect_to couple_events_path(@couple), notice: 'Evento removido com sucesso!' }
    end
  end

  def destroy_image
    @goal = @couple.events.find(params[:id])
    image = @goal.images.find(params[:image_id])
    image.purge
  
    respond_to do |format|
      format.html { redirect_to edit_couple_goal_path(@couple, @goal), notice: "Imagem removida com sucesso." }
      format.json { head :no_content }
    end
  end

  private

  def set_event
    @event = @couple.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date, :event_type, images: [])
  end
end
