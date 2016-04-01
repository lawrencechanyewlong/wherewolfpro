class EventController < ApplicationController
  attr_accessor :latlng
  attr_accessor :formatted_address
  skip_before_action :verify_authenticity_token
  
  def event_params
    params.require(:event).permit(:address_lat, :address_lng, :receiver, :duration_setting, :uid, :message)
  end
  
  def new
    Event.new
  end

  def select_contacts
    
    user = User.where(:id => session[:id]).take
    if user
      @contacts = user.contacts
    end
    session[:latlng]
    logger.debug "latlng: #{session[:latlng]}"
    logger.debug "formatted_address: #{session[:formatted_address]}"
  end
  
  def geocoding
    respond_to do |format|               
      format.js
    end
  end

  def select_destination
  end
  
  def store_destination
    logger.debug "In store_destination"
    @latlng = {lat: params[:lat], long: params[:long]}
    @formatted_address = params[:formatted_address]
    
    session[:latlng] = @latlng
    session[:formatted_address] = @formatted_address
    
    logger.debug "latlng: #{session[:latlng]}"
    logger.debug "formatted_address: #{session[:formatted_address]}"
    
    render text: "<script>window.location = '#{event_select_contacts_path}';</script>", status: 500
  end

  def select_duration
    @duration = params
    session[:duration] = @duration
  end
  
  def store_duration
    @duration = {'1': "Until I Arrive"} if params[:arrive]
    @duration = {'2': "#{params[:until_this_time]} am"} if params[:until_this_time] != '0' && params[:am]
    @duration = {'3': "#{params[:until_this_time]} pm"} if params[:until_this_time] != '0' && params[:pm]
    @duration = {'4': "#{params[:for_this_many_hours]} hours"} if params[:for_this_many_hours] != '0'
    session[:duration] = {'duration': @duration} 
    render text: " <script>window.location = '#{event_message_path}';</script>", status: 500
  end

  def confirm
    logger.debug "latlng: #{session[:latlng]}"
    logger.debug "formatted_address: #{session[:formatted_address]}"
    @duration = session[:duration]['duration'].values[0] if session[:duration]['duration']
  end

=begin  
  def message
    @event = Event.find(params[:id])
    @event.save!(params[:message])
  end
=end
end
