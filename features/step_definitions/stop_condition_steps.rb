And /^my current lat is "(.*)" and long is "(.*)"/ do |lat, lng|
    event = Event.find(1)
    event.current_lat = lat
    event.current_lng = lng
    event.save!
    # print event.duration_setting
    visit current_path
    visit current_path
    # print event.duration_setting, event.current_lat, event.current_lng, event.address_lat, event.address_lng, event.active, event.id
end