# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PASSWORD = "HelloWorld10".freeze

# Clear everything
User.delete_all
Chirp.delete_all
Relationship.delete_all

# Create admin users.
User.create!(name: "Lucas Helloworld", email: "asmrit1010@gmail.com", password: PASSWORD,
  password_confirmation: PASSWORD, admin: true, activated: true, activated_at: Time.current)
User.create(name: "Admin100 Smith", email: "admin@admin.com", password: PASSWORD,
  password_confirmation: PASSWORD, admin: true, activated: true, activated_at: Time.current)

# Create users.
100.times do
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  User.create!(name: name, email: email, password: PASSWORD, password_confirmation: PASSWORD, activated: true,
    activated_at: Time.current)
end

# Create chirps.
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.chirp.create!(content: content) }
end

# Create following relationships.
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
