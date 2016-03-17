class EventController < ApplicationController
  def new
  end

  def select_contacts
    
    contacts = request.env['omnicontacts.contacts']
    #name =  contacts['name']
    #@authorization = Authorization.find_by_provider_and_uid(contacts["provider"], contacts["uid"])
    #if @authorization
     # session[:id] = @authorization.id
    #else
     # user = User.new :name => name, :email => email
      #user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      #contact_list = []
      #contacts.each do |contact|
      #  contact_list += ["#{contact[:email]}"]
      #end
      #user.save
    #end
    #session[:id] = user.id
    if contacts 
      @contacts = []
      contacts.each do |contact|
        @contacts += ["#{contact[:email]}"]
      end
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
