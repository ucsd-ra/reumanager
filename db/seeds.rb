# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u = User.create(:email => 'jgrevich@ucsd.edu', :password => 'buddha')
u.confirmed_at = DateTime.now
u.save
u = User.create(:email => 'be-uginfo@bioeng.ucsd.edu', :password => 'demonstration')
u.confirmed_at = DateTime.now
u.save