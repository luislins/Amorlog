class TimelinesController < ApplicationController

  def index
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
end
