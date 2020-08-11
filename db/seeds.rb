# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Event.destroy_all
Attendance.destroy_all

50.times do |x|
  user = User.create! :first_name => Faker::Name.first_name, :last_name => Faker::Name.last_name, :email => Faker::Internet.email, :description => Faker::Lorem.paragraph_by_chars(number: 20, supplemental: false), :password => 'topsecret', :password_confirmation => 'topsecret'
end

10.times do |x|
  event = Event.create!(title: Faker::Lorem.paragraph_by_chars(number: 12, supplemental: false), start_date: Time.now + 20, duration: 15, user_admin_id: User.all.sample.id, description: Faker::Lorem.paragraph_by_chars(number: 25, supplemental: false), price: rand(100..1000), location: Faker::Address.city)
end

30.times do |x|
  attendance = Attendance.create!(stripe_customer_id: "01254120122", user_id: User.all.sample.id, event_id: Event.all.sample.id)
end