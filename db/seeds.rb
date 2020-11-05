# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
require "date"

puts "Cleaning database..."
Property.destroy_all
Booking.destroy_all
User.destroy_all

puts "Creating users"
owner1 = User.new(
  email: "owner1@gmail.com",
  password: '111111'
)
owner1.save

owner2 = User.new(
  email: "owner2@gmail.com",
  password: '111111'
)
owner2.save

visitor1 = User.new(
  email: "visitor1@gmail.com",
  password: '111111'
)
visitor1.save

visitor2 = User.new(
  email: "visitor2@gmail.com",
  password: '111111'
)
visitor2.save

admin = User.new(
  email: "admin@gmail.com",
  password: '111111'
)
admin.save
puts "Created all users"


puts "Creating properties and bookings..."
20.times do
  newproperty = Property.new(
    title: ["Entire Apt", "Studio Apt", "Condo"].sample + " at " + Faker::Address.street_name,
    description: Faker::Lorem.paragraphs(number: 1).first,
    address: Faker::Address.full_address,
    price: rand(50..200),
    capacity: rand(1..4),
  )
  newproperty.user = [owner1, owner2].sample
  newproperty.save
  puts "Created #{newproperty.title}"

  newbooking = Booking.new(
    start_date: Date.today+10,
    end_date: Date.today+rand(10..20),
    price: rand(50..150)
  )
  newbooking.property = newproperty
  newbooking.user = [visitor1, visitor2].sample
  newbooking.save
  puts "Created booking"

end
puts "Finished!"
