class EventController < ApplicationController
  attr_accessor :latlng
  attr_accessor :formatted_address
  #attr_accessor :latitud
  #attr_accessor :longitud
  skip_before_action :verify_authenticity_token
  require 'gmail'
  def event_params
    params.require(:event).permit(:address_lat, :address_lng, :receiver, :duration_setting, :uid, :message)
  end

  def select_contacts
    user = User.where(:id => session[:id]).take
    if user
      @receiver_all = []
      @receiver_name_all = []
      user.contacts.each do |c|
        @receiver_name_all << c[0]
        @receiver_all << c[1]
      end
      # @receiver_all = user.contacts 
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
    logger.debug params.inspect
    puts "HELLO"
    @receiver = []
    @receiver_name = []
    params.each do |k, v|
      if k =~ /^info_.*$/
        @temp = v.split(', ')
        @receiver_name << @temp[0]
        @receiver << @temp[1]
      end
    end
    session[:receiver] = @receiver
    session[:receiver_name] = @receiver_name
    # if params[:receiver_name] and params[:receiver]
    #   session[:receiver] = params[:receiver]
    #   session[:receiver_name] = params[:receiver_name]
    # end
    logger.debug "receiver: #{session[:receiver]}"
    # render text: "<script>window.location = '#{event_select_duration_path}';</script>", status: 200
    redirect_to '/event/select_duration'
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
    logger.debug params.inspect
    if params[:message]
      session[:message] = params[:message]
    else
      session[:message] = ""
    end
    logger.debug session[:message]
    redirect_to '/event/summary'
    # render text: "<script>window.location = '#{event_summary_path}';</script>", status: 200
  end
  
  def live_tracking

    id = params[:id]
    if Event.exists?(id: id)
      @event = Event.find(id)
      if @event.active == true
        @latlong = {lat: params[:latitude], lng: params[:longitude]}
        logger.debug "latlong = #{@latlong}"
        session[:latlong] = @latlong
        #logger.debug "latlong = #{session[:latlong]}"
        $latitud = params[:latitude]
        $longitud = params[:longitude]
        logger.debug "lat = #{$latitud}"
        
        # check condition for turning active off
        @event.current_lat = $latitud
        @event.current_lng = $longitud
      else
        redirect_to welcome_index_path
      end
    else
      redirect_to welcome_index_path
    end

    
  end
  
  def send_mail
    gmail = Gmail.new('woofwhere', 'battle431101')
    
    redirect_to "/"
    message = session[:message]
    if session[:receiver]
      if session[:receiver].is_a?(String)
        receiver = session[:receiver]
        gmail.deliver do
          to receiver
          subject "Welcome to wherewoof" 
          text_part do
            body "Wherewoof is here for you. The message is " + message
          end
        end
        return
      end
      session[:receiver].each do |messenger|
        gmail.deliver do
          to messenger
          subject "Welcome to wherewoof " + session[:message]
          text_part do
            
            body "Wherewoof is here for you. The message is " + message
          end
        end
      end
    end
  end
  
  def tracking
    #@sess = session[:latlong]
    #logger.debug "sess = #{session[:latlong]}"
    @lati = $latitud
    logger.debug "lati = #{@lati}"
    @longi = $longitud
    logger.debug "longi = #{@longi}"

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
  
  def create_event
    @event = Event.create!(
        :uid => session[:uid],
        :address_lat => session[:address_lat],
        :address_lng => session[:address_lng],
        :receiver => session[:receiver],
        :datetime_sent => session[:datetime_sent],
        :duration_setting => session[:duration_setting],
        :active => true,
        :address_string => session[:address_string],
        :receiver_name => session[:receiver_name],
        :message => session[:message],
        # :current_lat => session[:current_lat],
        # :current_lng => session[:current_lng]
      )
      
      #not sure if this path is defined
    # redirect_to event_live_tracking_path(@event)
    redirect_to controller: 'event', action: 'live_tracking', id: @event.id
  end

end
