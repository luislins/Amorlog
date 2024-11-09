module EventsHelper
    # Classes de estilo para o card do evento baseado no tipo
    def event_type_card_class(event_type)
      case event_type
      when "goal" then "bg-blue-500 text-white"
      when "memory" then "bg-green-500 text-white"
      when "other" then "bg-yellow-500 text-white"
      else "bg-gray-800 text-white"
      end
    end
  
    # Classes de badge para o tipo de evento
    def badge_class(event_type)
      case event_type
      when "goal" then "bg-blue-700 text-white"
      when "memory" then "bg-green-700 text-white"
      when "other" then "bg-yellow-700 text-white"
      else "bg-gray-700 text-white"
      end
    end
  
    # Formata o nome do tipo de evento
    def format_event_type(event_type)
      case event_type
      when "goal" then "Meta"
      when "memory" then "Memória"
      when "other" then "Outro"
      else "Desconhecido"
      end
    end
  end
  