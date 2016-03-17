class EventController < ApplicationController
  def new
  end

  def select_contacts
    
    contacts = request.env['omnicontacts.contacts']
    user_data = request.env['omnicontacts.user']
   
    name = user_data[:name]
    email = user_data[:email]
    user = User.find_by email: user_data[:email]
    if user
      @contacts = user.contacts
      session[:id] = user.id
      return
    end
    user = User.new :name => name, :email => email
    contact_list = []
    session[:id] = user.id
    contacts.each do |contact|
      contact_list += ["#{contact[:email]}"]
    end
    user.contacts = contact_list
    user.save!
    @contacts = user.contacts
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
