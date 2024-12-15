class TimelinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_couple

  def index
    @couple = Couple.find_by!(slug: params[:couple_slug])

    events = @couple.events.map do |event|
      {
        type: :event,
        title: event.title,
        description: event.description,
        date: event.date,
        event_type: event.event_type
      }
    end

    goals = @couple.goals.map do |goal|
      {
        type: :goal,
        title: goal.title,
        description: goal.description,
        date: goal.due_date,
        achieved: goal.achieved,
        kind: goal.kind, # Preserva o valor original para flexibilidade
        numeric_value: goal.numeric_value,
        current_value: goal.current_value,
        images: goal.images.map { |image| url_for(image) } # Gera URLs para as imagens
      }
    end

    @timeline_items = (events + goals).sort_by { |item| item[:date] }
  end

  private

  def set_couple
    @couple = Couple.find_by(slug: params[:couple_slug])

    # Verifica se o casal pertence ao usuário autenticado
    return unless @couple.nil? || @couple.user != current_user

      redirect_to root_path, alert: 'Acesso não autorizado.'
  end

end
