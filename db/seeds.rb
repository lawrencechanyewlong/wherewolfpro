# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [{:name => 'Eric', :password => 'citydogshare', :email => 'erichusk@gmail.com', :provider => 'Google'},
        {:name => 'Melvyn', :password => 'password', :email => 'sngguojie@gmail.com', :provider => 'Google'}
    ]
    
users.each do |user|
    User.create!(user)
end

events = [{:uid => '2', :address_lat => 37.6189, :address_lng => 122.3750, :receiver => '5107100734', :datetime_sent => DateTime.current(), :duration_setting => '1 hour', :active => true}
    ]
    
events.each do |event|
    Event.create!(event)
end

saved_locations = [{:name => 'UC Berkeley', :address_lat => 37.8700, :address_lng => 122.2590, :uid => '2'},
        {:name => 'SFO', :address_lat => 37.6189, :address_lng => 122.3750, :uid => '2'}
    ]

saved_locations.each do |location|
    SavedLocation.create!(location)
end