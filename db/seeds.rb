# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"
require "date"
require "open-uri"
require_relative "scraper.rb"

# file = URI.open('https://giantbomb1.cbsistatic.com/uploads/original/9/99864/2419866-nes_console_set.png')
# article = Article.new(title: 'NES', body: "A great console")
# article.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')

puts "Cleaning database..."
Property.destroy_all
Booking.destroy_all
User.destroy_all

puts "Creating users"
owner1 = User.new(
  email: "owner1@gmail.com",
  password: '111111',
  username: "Mika"
)
owner1.save

owner2 = User.new(
  email: "owner2@gmail.com",
  password: '111111',
  username: "Adrien"
)
owner2.save

visitor1 = User.new(
  email: "visitor1@gmail.com",
  password: '111111',
  username: "Yuva"
)
visitor1.save

visitor2 = User.new(
  email: "visitor2@gmail.com",
  password: '111111',
  username: "Anton"
)
visitor2.save

admin = User.new(
  email: "admin@gmail.com",
  password: '111111',
  admin: true,
  username: "Flo"
)
admin.save
puts "Created all users"


puts "Creating properties and bookings..."

address_in_sg = [
  {
    address: 'Floor 33 @ Courtyard Marriott, 99, Irrawaddy Rd, Singapore 329568',
    latitude: 1.320700,
    longitude: 103.843360
  },
  {
    address: '238 Thomson Rd, #02 - 49 / 50, Singapore 307683',
    latitude: 1.319310,
    longitude: 103.844180
  },
  {
    address: '1 Cluny Rd, Singapore 259569',
    latitude: 1.315470,
    longitude: 103.817261
  },
  {
    address: '1 Orchard Blvd, #01-01/02 Camden Medical Centre, Singapore 248649',
    latitude: 1.282190,
    longitude: 103.852510
  },
  {
    address: '481 Bukit Timah Rd, Singapore 259769',
    latitude: 1.322790,
    longitude: 103.815150
  },
    {
    address: '240 Sime Rd, Singapore 288303',
    latitude: 1.34283705,
    longitude: 103.80916124
  },
    {
    address: '15 Science Centre Rd, Singapore 609081',
    latitude: 1.3328377,
    longitude: 103.73601896
  },
    {
    address: '51 Chinese Cemetery Path 4, Singapore 698932',
    latitude: 1.3773356,
    longitude: 103.688141
  },
  {
    address: '1 Turf Club Avenue Singapore Racecourse, Singapore 738078',
    latitude: 1.4190866,
    longitude: 103.7594086
  }
]

10.times do
  property = address_in_sg.sample
  newproperty = Property.new(
    title: ["Entire Apt", "Studio Apt", "Condo"].sample + " at " + Faker::Address.street_name,
    description: Faker::Lorem.paragraphs(number: 1).first,
    address: property[:address],
    price: rand(50..200),
    capacity: rand(1..4),
    latitude: property[:latitude],
    longitude: property[:longitude]
  )
  newproperty.user = [owner1, owner2].sample

  sampleimages = [
    "https://images.adsttc.com/media/images/5ecd/d4ac/b357/65c6/7300/009d/medium_jpg/02C.jpg?1590547607",
    "https://a0.muscache.com/im/pictures/c34e2dff-8e29-4567-a65d-0ac02d97545b.jpg?im_w=1200",
    "https://a0.muscache.com/im/pictures/957aff4e-aaaf-4195-8084-b7f9b871b7a7.jpg?im_w=960",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTHhl2qH61IMYbZD77iWhgy-4TiLq1cRAPPSA&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRd0z0kTwkXPXeCtGI4sJg6-WmoD0XqlPkdrQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTmz1lKPojj8GFS8INs0JYNbqTrlNhIhKPJrw&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRQwOxPgo1wQf86te2IsV1TqUS-o_izuxvcXA&usqp=CAU"
  ].sample

  file = URI.open(sampleimages)
  newproperty.photos.attach(io: file, filename: 'sample.png', content_type: 'image/png')
  newproperty.save
  puts "Created #{newproperty.title}"

  start_date = Date.today+rand(10..100)
  end_date = start_date + rand(10..20)

  newbooking = Booking.new(
    start_date: start_date,
    end_date: end_date,
    price: newproperty.price * (end_date - start_date)
  )
  newbooking.property = newproperty
  newbooking.user = [visitor1, visitor2].sample
  newbooking.save
  puts "Created booking"

end
puts "Finished!"



