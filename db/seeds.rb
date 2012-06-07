# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user.name
user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user2.name
user.add_role :admin

Venue.delete_all

require 'csv'    
csv_text = File.read("#{Rails.root}/db/venues-seed.csv")

csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|

  venue = Venue.create!(
        :name => row[1],
        :street_address => row[2],
        :suburb => row[3],
        :postcode => row[4],
        :phone_number => row[5],
        :url => row[6]
    )
  venue.trading_times.create!(
        :monday_opens_at => row[7],
        :monday_closes_at => row[8],
        :tuesday_opens_at => row[9],
        :tuesday_closes_at => row[10],
        :wednesday_opens_at => row[11],
        :wednesday_closes_at => row[12],
        :thursday_opens_at => row[13],
        :thursday_closes_at => row[14],
        :friday_opens_at => row[15],
        :friday_closes_at => row[16],
        :saturday_opens_at => row[17],
        :saturday_closes_at => row[18],
        :sunday_opens_at => row[19],
        :sunday_closes_at => row[20]
    )
  puts venue.trading_times.inspect
end
