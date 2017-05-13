# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Donation.destroy_all
Comment.destroy_all
User.destroy_all
Category.destroy_all
Project.destroy_all

User.find_or_create_by(email: 'admin@admin.com', password: '123123',
                       username: 'admin', name: 'Administrador',
                       last_name: 'Admin', admin: true)
User.find_or_create_by(email: 'jicortes2@uc.cl', password: '123123',
                      username: 'jicortes2', name: 'Juan Ignacio',
                      last_name: 'Cortés Vergara', admin: true)
15.times do
  password = Faker::Internet.password(8)
  User.create(email: Faker::Internet.unique.email,
              username: Faker::Internet.unique.user_name,
              password: password,
              password_confirmation: password,
              name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              admin: false)
end

Category.find_or_create_by(name: 'Tecnología')
Category.find_or_create_by(name: 'Juegos de mesa')
Category.find_or_create_by(name: 'Deportes')
Category.find_or_create_by(name: 'Artesanía')
Category.find_or_create_by(name: 'Comics')
Category.find_or_create_by(name: 'Armaduras')
Category.find_or_create_by(name: 'Armas')
100.times do
  offset = rand(User.count)
  user = User.offset(offset).first
  offset2 = rand(Category.count)
  category = Category.offset(offset2).first
  Project.create(goal: rand*Random.rand(100000),
                 title: Faker::Lorem.sentence,
                 description: Faker::Lorem.paragraph(2),
                 user_id: user.id,
                 category_id: category.id,
                 publish: true
                 )
end
