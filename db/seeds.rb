# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#clear all records first
puts "destroying all duplicate records"
Exercise.destroy_all
Workout.destroy_all
Program.destroy_all
LiftDetail.destroy_all

# user
# will already be created id: 1
user = User.find_by_email "god@popeyeapp.com"

puts "trying out the new nifty factory"

StorePrograms::StartingStrengthFactory.new(user).create

