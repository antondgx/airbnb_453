# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"

puts "Cleaning database..."
Property.destroy_all
Booking.destroy_all

puts "Creating properties..."
20.times do
property = Property.new(
  title: Faker::Address.street_name,
  description: Faker::Lorem.paragraphs(number: 1).first,
  address: Faker::Address.full_address,
  price: rand(50..100),
  capacity: rand(1..4),
  user_id: rand(1..3)
)
property.save
puts "Created #{property.title}"
end
puts "Finished!"

    # t.string "title"
    # t.text "description"
    # t.string "address"
    # t.integer "price"
    # t.integer "capacity"
