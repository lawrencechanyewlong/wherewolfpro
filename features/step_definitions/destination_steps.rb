Given /the following saved destinations exist/ do |locations_table|
  locations_table.hashes.each do |location|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    # Movie.create(movie)
    temp = SavedLocation.new
    temp.name = location[:name]
    temp.address_lat = location[:address_lat]
    temp.address_lng = location[:address_lng]
    temp.save
  end
  # fail "Unimplemented"
end