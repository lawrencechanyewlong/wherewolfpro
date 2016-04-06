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
      if params['email']
        if params['email'].length == 0
          flash['notice'] = 'Invalid'
          return
        else
          flash['notice'] = 'user created'
        end
        if @contacts
          @contacts = [params['email']] + @contacts
        else
          @contacts = [params['email']]
        end
        user.contacts = @contacts
        user.save!
      end
    end

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
    if params[:info]
      session[:info] = params[:info].keys
    end
    @duration = params
    session[:duration] = @duration
  end
  
  def store_duration
    @duration = {'1': "Until I Arrive"} if params[:arrive]
    @duration = {'2': "#{params[:until_this_time]} am"} if params[:until_this_time] != '0' && params[:am]
    @duration = {'3': "#{params[:until_this_time]} pm"} if params[:until_this_time] != '0' && params[:pm]
    @duration = {'4': "#{params[:for_this_many_hours]} hours"} if params[:for_this_many_hours] != '0'
    session[:duration] = @duration
    render text: " <script>window.location = '#{event_message_path}';</script>", status: 500
  end

  def summary

    logger.debug "session[:info]: #{session[:info]}"
    logger.debug "session[:formatted_address]: #{session[:formatted_address]}"
    logger.debug "session[:duration]: #{session[:duration]}"
    logger.debug "latlng: #{session[:latlng]}"
    logger.debug "formatted_address: #{session[:formatted_address]}"
    logger.debug "message: #{session[:message]}"
    if session[:duration].is_a?(String)
      @duration = session[:duration]
    else
      @duration = session[:duration].values[0] if session[:duration]
    end
  end

 
  def message
  end
 
  def store_message
   # @event = Event.find(params[:id])
   @message = params[:message]
   session[:message] = @message
   
   
   render text: "<script>window.location = '#{event_summary_path}';</script>", status: 500
  end

  def store_event
    if params[:eid]
      @eid = params[:eid]
      @event = Event.where(eid: @eid.to_i).first
      logger.debug "event: #{@event.inspect}"
      @receiver_name = @event[:receiver_name]
      @receiver = @event[:receiver]
      @formatted_address = @event[:address_string]
      @duration_setting = @event[:duration_setting]
      @datetime_sent = @event[:datetime_sent]

      # session[:receiver_name] = @receiver_name
      session[:info] = @receiver
      session[:formatted_address] = @formatted_address
      session[:duration] = @duration_setting
      # session[:datetime_sent] = @datetime_sent
      session[:message] = ""

      logger.debug "session[:info]: #{session[:info]}"
      logger.debug "session[:formatted_address]: #{session[:formatted_address]}"
      logger.debug "session[:duration]: #{session[:duration]}"
      
      render text: "<script>window.location = '#{event_summary_path}';</script>", status: 200
    end

  end

end
