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

# User.create first_name: "Derek", last_name: "Owusu-Frimpong", username: "paayaw", email: "deepsky_5@live.com", password: "password", password_confirmation: "password",
#  phonenumber: "0204704427", gender: "male", age: 28, admin: true, seller: true, admin_access_level: :super_admin

admin_super_one = {
	first_name: "Derek", last_name: "Owusu-Frimpong", username: "paayaw", email: "superadmin1@email.com", password: "password", password_confirmation: "password",
 phonenumber: "0204704427", gender: "male", age: 28, admin: true, seller: true, admin_access_level: :super_admin
}

admin_super_two = {
	first_name: "jide", last_name: "Otoki", username: "username", email: "superadmin2@email.com", password: "password", password_confirmation: "password",
 phonenumber: "0000000000", gender: "male", age: 0, admin: true, seller: true, admin_access_level: :super_admin
}

array_of_super_admins = [admin_super_one, admin_super_two]


array_of_super_admins.each do |admin_attributes|
  User.create admin_attributes
end