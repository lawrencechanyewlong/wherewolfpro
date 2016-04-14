class EventController < ApplicationController
  attr_accessor :latlng
  attr_accessor :formatted_address
  skip_before_action :verify_authenticity_token
  
  def event_params
    params.require(:event).permit(:address_lat, :address_lng, :receiver, :duration_setting, :uid, :message)
  end

  def select_contacts
    user = User.where(:id => session[:id]).take
    if user
      @receiver_all = user.contacts 
      if params['email']
        if params['email'].length == 0 or params['name'].length == 0
          flash['notice'] = 'Invalid'
          return
        else
          flash['notice'] = 'user created'
        end
        if @receiver_all
          @receiver_all = [params['email']] + @receiver_all
        else
          @receiver_all = [params['email']]
        end
        if @receiver_name_all
          @receiver_name_all = [params['name']] + @receiver_name_all
        else
          @receiver_name_all = [params['name']]
        end
        user.contacts = @receiver_all
        user.save!
      end
    else
      @receiver_all = session[:receiver_all]
      @receiver_name_all = session[:receiver_name_all]
      if params['email'] and params['name']
        if params['email'].length == 0 or params['name'].length == 0
          flash['notice'] = 'Invalid'
          return
        else
          flash['notice'] = 'user created'
          if @receiver_all
            @receiver_all = [params['email']] + @receiver_all
          else
            @receiver_all = [params['email']]
          end
          if @receiver_name_all
            @receiver_name_all = [params['name']] + @receiver_name_all
          else
            @receiver_name_all = [params['name']]
          end
          logger.debug @receiver_all
          session[:receiver_all] = @receiver_all
          session[:receiver_name_all] = @receiver_name_all
        end
      end
    end
  end

  def store_contacts
    logger.debug "In store_contacts"
    puts "HELLO"
    if params[:receiver_name] and params[:receiver]
      session[:receiver] = params[:receiver]
      session[:receiver_name] = params[:receiver_name]
    end
    logger.debug "receiver: #{session[:receiver]}"
    render text: "<script>window.location = '#{event_select_duration_path}';</script>", status: 200
  end
  
  def geocoding
    respond_to do |format|               
      format.js
    end
  end

  def select_destination
    @address_lat_init = 37.7749
    @address_lng_init = -122.4194
    @address_lat = 37.7749
    @address_lng = -122.4194
    if session[:address_lat] and session[:address_lng]
      @address_lat = session[:address_lat]
      @address_lng = session[:address_lng]
      @address_lat_init = @address_lat
      @address_lng_init = @address_lng
    end
  end
  
  def store_destination
    logger.debug "In store_destination"
    # @latlng = {lat: params[:lat], long: params[:long]}
    # @formatted_address = params[:formatted_address]
    
    session[:address_lat] = params[:lat]
    session[:address_lng] = params[:long]
    session[:address_string] = params[:formatted_address]
    
    # logger.debug "latlng: #{session[:latlng]}"
    # logger.debug "formatted_address: #{session[:formatted_address]}"
    
    render text: "<script>window.location = '#{event_select_contacts_path}';</script>", status: 200
  end

  def select_duration
    @duration = session[:duration_setting]
  end
  
  def store_duration
    logger.debug params.inspect
    if params[:arrive]
      @duration = 'arrive'
    elsif params[:until_this_time] != '0'
      if params[:am]
        @duration = "#{params[:until_this_time]} am"
      elsif params[:pm]
        @duration = "#{params[:until_this_time]} pm"
      else
        @duration = nil
      end
    elsif params[:for_this_many_hours] != '0'
      @duration = "#{params[:for_this_many_hours]} hours"
    else
      @duration = nil
    end
    if @duration
      session[:duration_setting] = @duration
      logger.debug "duration"
      render text: "<script>window.location = '#{event_message_path}';</script>", status: 200
    else
      render text: "<script>window.location = '#{event_select_duration_path}';</script>", status: 400
    end
  end

  def summary
    
    def parseDuration(d)
      if d
        if d == 'arrive'
          return 'Until I arrive'
        elsif d[d.size-1] == 'm'
          return 'Until '+d
        elsif d[d.size-1] == 's'
          return 'For '+d
        else
          return nil
        end
      else
        return nil
      end
    end
    logger.debug "receiver: #{session[:receiver]}"
    @address_string = session[:address_string]
    @address_lat = session[:address_lat]
    @address_lng = session[:address_lng]
    if @address_lat == "37.7749" and @address_lat == "-122.4194"
      @address_lat = "-"
      @address_lng = "-"
    end
    logger.debug session[:receiver_name].is_a?(String)
    @receiver_name = if session[:receiver_name].is_a?(String) then [session[:receiver_name]] else session[:receiver_name] end
    @receiver = if session[:receiver].is_a?(String) then [session[:receiver]] else session[:receiver] end
    @duration = parseDuration(session[:duration_setting])
    @message = session[:message]
  end


  def message
    if session[:message]
      @message = session[:message]
    else
      @message = nil
    end
  end
 
  def store_message
    if params[:message]
      session[:message] = params[:message]
    else
      session[:message] = ""
    end
    render text: "<script>window.location = '#{event_summary_path}';</script>", status: 200
  end
  
  def live_tracking
    @latlong = {lat: params[:latitude], lng: params[:longitude]}
    logger.debug "latlong = #{@latlong}"
    session[:latlong] = @latlong
    
  end
  
  def tracking
  end

  def store_event
    if params[:eid]
      @eid = params[:eid]
      @event = Event.where(id: @eid.to_i).first
      logger.debug "event: #{@event.inspect}"
      @receiver_name = @event[:receiver_name]
      @receiver = @event[:receiver]
      @formatted_address = @event[:address_string]
      @duration_setting = @event[:duration_setting]
      # @datetime_sent = @event[:datetime_sent]

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
