class EventController < ApplicationController
  def new
  end

  def select_contacts
    
    user = User.where(:id => session[:id]).take
    if user
      @contacts = user.contacts
    end
  end
  
  def geocoding
    respond_to do |format|               
      format.js
    end
  end

  def select_destination
=begin
    # need user's location
    
    temp = SavedLocation.new
    temp.name = "International House Berkeley"
    temp.address_lat = 37.871593
    temp.address_lng = -122.272747
    temp.save
    
    @saved_locations = SavedLocation.all
    
    @hash = Gmaps4rails.build_markers(@saved_locations) do |location, marker|
      marker.lat 37.871593 # user.latitude
      marker.lng -122.272747 # user.longitude
      # marker.infowindow locat.description
      # marker.json({ title: user.title })
    end
=end
    
  end

  def select_duration
  end

  def confirm
  end
end
