after :roles do
  User.seed(:id,
    { id: 1, firstname: 'John',   lastname: 'Snow',  email: 'john.snow@example.com', password: 'qwerty123', password_confirmation: 'qwerty123' },
    { id: 2, firstname: 'Eddard', lastname: 'Stark', email: 'nedstark@example.com',  password: 'qwerty123', password_confirmation: 'qwerty123' },
    { id: 3, firstname: 'Tyrion', lastname: 'Lannister', email: 'admin@example.com', password: 'qwerty123', password_confirmation: 'qwerty123' }
  )
  User.find(3).roles << Role.find(1)
end
