class EventController < ApplicationController
  def new
  end

  def select_contacts
  end

  def select_destination
    # need user's location
    """
    @users = User.all
    
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.description
      marker.json({ title: user.title })
    end
    """
  end

  def select_duration
  end

  def confirm
  end
end
