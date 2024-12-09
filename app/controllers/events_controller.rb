class EventsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!
  before_action :set_couple
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
      redirect_to couple_events_path, notice: 'Evento criado com sucesso!'
    else
      render :new
    end
  end

  def edit; end

  def destroy
    @event.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(dom_id(@event))
      end
      format.html { redirect_to couple_event_path(@couple.slug), notice: 'Evento removido com sucesso!' }
    end
  end

  private

  def set_couple
    @couple = Couple.find_by(slug: params[:couple_slug])

    # Verifica se o casal pertence ao usuário autenticado
    return unless @couple.nil? || @couple.user != current_user

      redirect_to root_path, alert: 'Acesso não autorizado.'
  end

  def set_event
    @event = @couple.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :date, :event_type)
  end
end
