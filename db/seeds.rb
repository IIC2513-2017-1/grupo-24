# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(email: 'admin@admin.com', password: '123123',
                       username: 'admin', name: 'Administrador',
                       last_name: 'Admin', admin: true)
User.find_or_create_by(email: 'jicortes2@uc.cl', password: '123123',
                      username: 'jicortes2', name: 'Juan Ignacio',
                      last_name: 'Cortés Vergara', admin: true)
5.times do
  User.create(email: Faker::Internet.unique.email,
              username: Faker::Internet.unique.user_name,
              password: Faker::Internet.password(8),
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

10.times do
  Project.create(goal: rand*Random.rand(100000000),
                 title: Faker::Lorem.sentence,
                 description: Faker::Lorem.paragraph(2),
                 user_id: rand(6)+1,
                 category_id: rand(6)+1,
                 publish: true
                 )
end
