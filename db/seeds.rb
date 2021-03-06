# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


  # Пользователи
User.create!(username:  "Example User",
email: "example@railstutorial.org",
password:              "foobar",
admin: true 
)

5.times do |n|
username  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(username: username,
 email: email,
 password:              password,
)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end
# Взаимоотношения
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

