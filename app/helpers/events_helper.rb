module EventsHelper
    def format_event_type(event_type)
        case event_type
        when 'first_date' then 'Primeiro Encontro'
        when 'first_kiss' then 'Primeiro Beijo'
        when 'anniversary' then 'Aniversário de Namoro'
        when 'wedding_anniversary' then 'Aniversário de Casamento'
        when 'trip' then 'Viagem Juntos'
        when 'local_exploration' then 'Exploração Local'
        when 'picnic' then 'Piquenique'
        when 'holiday' then 'Feriado'
        when 'party' then 'Festa'
        when 'special_date' then 'Data Comemorativa'
        when 'movie_night' then 'Filme ou Série'
        when 'dinner' then 'Jantar'
        when 'relaxing_day' then 'Dia de Relaxamento'
        when 'meet_family' then 'Conhecendo a Família'
        when 'partner_birthday' then 'Aniversário do Parceiro'
        when 'child_birthday' then 'Aniversário do Filho'
        when 'course_together' then 'Curso Juntos'
        when 'creative_project' then 'Projeto Criativo'
        when 'first_purchase' then 'Primeira Compra'
        when 'support_moment' then 'Momento de Apoio'
        when 'first_resolution' then 'Discussão Resolvida'
        when 'unusual_experience' then 'Experiência Inusitada'
        else 'Outro'
        end
    end

      def event_type_options
        [
          ['Selecione o tipo', nil],
          ['Primeiro Encontro', 'first_date'],
          ['Primeiro Beijo', 'first_kiss'],
          ['Aniversário de Namoro', 'anniversary'],
          ['Aniversário de Casamento', 'wedding_anniversary'],
          ['Viagem Juntos', 'trip'],
          ['Exploração Local', 'local_exploration'],
          ['Piquenique ao Ar Livre', 'picnic'],
          ['Feriados Juntos', 'holiday'],
          ['Festas e Eventos', 'party'],
          ['Datas Comemorativas', 'special_date'],
          ['Filme ou Série Assistidos', 'movie_night'],
          ['Jantar Juntos', 'dinner'],
          ['Dia de Relaxamento', 'relaxing_day'],
          ['Conhecendo a Família', 'meet_family'],
          ['Aniversário de Um dos Parceiros', 'partner_birthday'],
          ['Aniversário de um Filho', 'child_birthday'],
          ['Curso ou Atividade Juntos', 'course_together'],
          ['Projeto Criativo Juntos', 'creative_project'],
          ['Primeira Compra Importante', 'first_purchase'],
          ['Momento de Apoio', 'support_moment'],
          ['Primeira Discussão Resolvida', 'first_resolution'],
          ['Experiência Inusitada', 'unusual_experience']
        ]
      end

    # Classes de estilo para o card do evento baseado no tipo
    def event_type_card_class(event_type)
      case event_type
      when 'goal' then 'bg-blue-500 text-white'
      when 'memory' then 'bg-green-500 text-white'
      when 'other' then 'bg-yellow-500 text-white'
      else 'bg-gray-800 text-white'
      end
    end

    # Classes de badge para o tipo de evento
    def badge_class(event_type)
      case event_type
      when 'goal' then 'bg-blue-700 text-white'
      when 'memory' then 'bg-green-700 text-white'
      when 'other' then 'bg-yellow-700 text-white'
      else 'bg-gray-700 text-white'
      end
    end
end
