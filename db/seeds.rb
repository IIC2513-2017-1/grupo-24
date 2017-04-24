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
User.find_or_create_by(email: 'jicortes2@uc.com', password: '123123',
                      username: 'jicortes2', name: 'Juan Ignacio',
                      last_name: 'Cortés Vergara', admin: true)
User.find_or_create_by(email: 'juan.cv94@gmail.com', password: '123123',
                      username: 'juan', name: 'Juan',
                      last_name: 'Cortés', admin: false)
User.find_or_create_by(email: 'normal@normal.com', password: '123123',
                       username: 'normal', name: 'Normal',
                       last_name: 'User', admin: false)

Category.find_or_create_by(name: 'Tecnología')
Category.find_or_create_by(name: 'Juegos de mesa')
Category.find_or_create_by(name: 'Deportes')
Category.find_or_create_by(name: 'Artesanía')
Category.find_or_create_by(name: 'Comics')
Category.find_or_create_by(name: 'Armaduras')
Category.find_or_create_by(name: 'Armas')
