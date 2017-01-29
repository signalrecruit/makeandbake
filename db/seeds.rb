# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = ["Engagement Party", "Bridal Shower", "Rehearsal Dinner", "Vow Renewal", "Wedding Anniversary", "Conference",
 "Seminar", "Workshop", "Board Meeting", "Product Launch Party", "Employee Appreciation", "Networking Event", "Christmas Party",
 "New Year Party", "Easter Celebration", "Independence Day", "Valentine Day", "Family Picnic", "Birthday Party", "Vacation Party", 
 "Baby Shower" ]

categories.each do |category|
  Tag.find_or_create_by(name: category.downcase)
end

User.create first_name: "Derek", last_name: "Owusu-Frimpong", username: "paayaw", email: "deepsky_5@live.com", password: "password", password_confirmation: "password",
 phonenumber: "0204704427", gender: "male", age: 28, admin: true, seller: true, admin_access_level: :super_admin

# User.create( first_name: "Uchiha", last_name: "Sasuke", username: "Avenger", email: "sasuke@konoha.com", password: "password", password_confirmation: "password",
#  phonenumber: "0204704427", gender: "male", age: 28, admin: true, seller: true)

