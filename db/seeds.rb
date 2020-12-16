# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "HelloWorld10".freeze

User.delete_all

User.create!(name: "Lucas Helloworld", email: "asmrit1010@gmail.com", password: PASSWORD, password_confirmation: PASSWORD)

100.times do
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  User.create!(name: name, email: email, password: PASSWORD, password_confirmation: PASSWORD)
end
