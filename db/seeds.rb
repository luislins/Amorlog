# Create users
user1 = User.create!(email: 'a@gmail.com', password: '123456', password_confirmation: '123456')
user2 = User.create!(email: 'b@gmail.com', password: '123456', password_confirmation: '123456')

# Create couples
couple1 = Couple.create!(user: user1, partner_1: 'John', partner_2: 'Jane')

# Create events for couple1
Event.create!(couple: couple1, title: 'Anniversary', description: 'Celebrating 1 year together', date: '2025-06-01', event_type: 'Celebration')
Event.create!(couple: couple1, title: 'Vacation', description: 'Trip to Paris', date: '2025-08-15', event_type: 'Trip')

# Create goals for couple1
Goal.create!(couple: couple1, title: 'Save for honeymoon', description: 'Save $5000 for honeymoon in Paris', due_date: '2025-07-01', kind: 0, numeric_value: 5000, current_value: 1000)
Goal.create!(couple: couple1, title: 'Run a marathon', description: 'Train and run a marathon together', due_date: '2025-11-01', kind: 0)

# Create savings tables for couple1
savings_table1 = SavingsTable.create!(couple: couple1, current_value: 1000, max_value: 5000, max_value_per_square: 100, min_value_per_square: 50)
savings_table1.savings_table_squares.create!(value: 100, checked: false)
savings_table1.savings_table_squares.create!(value: 200, checked: false)

# Create more users
user3 = User.create!(email: 'c@gmail.com', password: '123456', password_confirmation: '123456')
user4 = User.create!(email: 'd@gmail.com', password: '123456', password_confirmation: '123456')

# Create couple2
couple2 = Couple.create!(user: user3, partner_1: 'Bob', partner_2: 'Alice')

# Create events for couple2
Event.create!(couple: couple2, title: 'Wedding', description: 'Our beautiful wedding day', date: '2025-05-20', event_type: 'Wedding')
Event.create!(couple: couple2, title: 'Move-in', description: 'We moved in together', date: '2025-01-15', event_type: 'Milestone')

# Create goals for couple2
Goal.create!(couple: couple2, title: 'Buy a house', description: 'Save for a down payment', due_date: '2025-12-01', kind: 0, numeric_value: 20000, current_value: 5000)
Goal.create!(couple: couple2, title: 'Learn a new language', description: 'Take a French course together', due_date: '2025-06-01', kind: 0)

# Create savings tables for couple2
savings_table2 = SavingsTable.create!(couple: couple2, current_value: 2000, max_value: 10000, max_value_per_square: 200, min_value_per_square: 100)
savings_table2.savings_table_squares.create!(value: 100, checked: true)
savings_table2.savings_table_squares.create!(value: 200, checked: false)

puts "Seed data created successfully!"
