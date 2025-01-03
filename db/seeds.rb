# Limpando o banco de dados
ActiveStorage::Attachment.delete_all
ActiveStorage::Blob.delete_all
Goal.delete_all
Event.delete_all
Couple.delete_all
User.delete_all

# Criando usuário principal
user = User.create!(
  email: 'a@gmail.com',
  password: '123456',
  password_confirmation: '123456'
)

# Criando casal
couple = Couple.create!(
  user: user,
  partner_1: 'Alice',
  partner_2: 'Bob'
)

# Criando eventos
5.times do |i|
  Event.create!(
    couple: couple,
    title: "Evento #{i + 1}",
    description: "Descrição para o evento #{i + 1}",
    date: Date.today + i * 10,
    event_type: ['Pessoal', 'Aniversário', 'Feriado'].sample
  )
end

# Criando metas
5.times do |i|
    kind = [0, 1].sample # 0 para numeric, 1 para boolean
    numeric_value = kind == 0 ? rand(100..1000) : nil
    current_value = if kind == 0
                      rand(0..(numeric_value || 1))
                    else
                      0 # Define como 0 para boolean ou um valor padrão válido
                    end
  
    begin
      Goal.create!(
        couple: couple,
        title: "Meta #{i + 1}",
        description: "Descrição para a meta #{i + 1}",
        due_date: Date.today + i * 30,
        achieved: kind == 1 ? [true, false].sample : false,
        kind: kind,
        numeric_value: numeric_value,
        current_value: current_value
      )
    rescue ActiveRecord::RecordInvalid => e
      puts "Erro ao criar meta #{i + 1}: #{e.message}"
      puts "Detalhes: #{e.record.errors.full_messages.join(', ')}"
    end
  end
  
  

puts "Database seeded successfully with dummy data."
