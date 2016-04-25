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
    @receiver = ''
    @receiver_name = ''
    params.each do |k, v|
      if k =~ /^info_.*$/
        @temp = v.split(', ')
        @receiver_name += @temp[0] + ', '
        @receiver += @temp[1] + ', '
      end
    end
    if @receiver.length > 0 and @receiver_name.length > 0
      session[:receiver] = @receiver[0..-3]
      session[:receiver_name] = @receiver_name[0..-3]
    else
      return redirect_to event_select_contacts_path
    end
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
      logger.debug "Something is wrong"
      @duration = nil
    end
    if @duration
      session[:duration_setting] = @duration
      logger.debug "duration"
      redirect_to event_message_path
      # render text: "<script>window.location = '#{event_message_path}';</script>", status: 200
    else
      redirect_to event_select_duration_path
      # render text: "<script>window.location = '#{event_select_duration_path}';</script>", status: 400
    end
  end

  def summary
    
    def parseDuration(d)
      if d
        if d == 'arrive'
          return 'Until I arrive'
        elsif d[d.size-1] == 'm'
          return 'Until '+d
        elsif d[d.size-1] == 's' or d[d.size-1] == 'r'
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
    @messagehistory = []
    Event.all.each do |e|
      if not e.message.to_s.empty?
        logger.debug "message: #{e.message}"
        @messagehistory << e
      end
    end
    @messagehistory = @messagehistory.uniq { |p| p.message }
    @messagehistory.sort!{ |x,y| y[:created_at] <=> x[:created_at] }
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
  
  def user_map
    
    def parseDurationToCheckCondition(d)
      # return true if condition is met and stop tracking, else return false if keep tracking
      if d == 'arrive'
        # check if location matches destination within a radius of about 50 metres
        current_distance = Geocoder::Calculations.distance_between([params[:latitude],params[:longitude]], [@event.address_lat,@event.address_lng])
        print current_distance
        stop_dist = 50/1600.0
        return current_distance < stop_dist
      elsif d[d.size-1] == 'm'
        #check the time each time he posts
        #not allowed to start at the exact same hour and minute as the end time
        hour = params[:hour].to_i
        minutes = params[:minutes].to_i
        if d[d.size-2] == 'p'
          # reach hour is set to the saved hour plus 12
          reachHour = (d.slice(0,d.size-3)).to_i + 12
        else
          # reach hour is set to the saved hour
          reachHour = (d.slice(0,d.size-3)).to_i
        end
        return (hour == reachHour and minutes == 0)
      elsif d[d.size-1] == 's'
        #check condition for this many hours
        num_hours = d[0, d.size-6].to_i
        return (@event.created_at.to_time + num_hours.hours) < Time.now
      else
        return nil
      end
    end
    
    id = params[:id]
    # print "event exists: ", Event.exists?(id: id)
    if Event.exists?(id: id)
      @event = Event.find(id)
      if @event.active == true
        #@latlong = {lat: params[:latitude], lng: params[:longitude]}
        #logger.debug "latlong = #{@latlong}"
        #session[:latlong] = @latlong
        #logger.debug "latlong = #{session[:latlong]}"
        #logger.debug "lat = #{$latitud}"
        #logger.debug "lat = #{params[:latitude]}"
        logger.debug "lat = #{params}"
        # check condition for turning active off
        @event.current_lat = params[:latitude]
        @event.current_lng = params[:longitude]
        @event.save!
        logger.debug "lat = #{@event.current_lat}"
        logger.debug "lng = #{@event.current_lng}"
        # condition = @event.duration_setting
        stop = parseDurationToCheckCondition(@event.duration_setting)
        if stop
          print "stop"
          @event.active = false
          @event.save!
          render :js => "window.location = '#{welcome_index_path}'" 
        else
          print "continue"
        end
      else
        redirect_to welcome_index_path
      end
    else
      redirect_to welcome_index_path
    end

    
  end
  
  def send_mail
    gmail = Gmail.new('woofwhere', 'battle431101')
    if session[:id]
      user = User.find_by id: session[:id]
      if user
        name = user.name
      else
        name = ""
      end
    else
      name = "an unspecified user"
    end 
    if name == nil
      name = "unspecified user"
    end
    message = session[:message]
    url = session['url']
    # redirect_to url
    if session[:receiver]
      if session[:receiver].is_a?(String)
        receiver = session[:receiver]
        gmail.deliver do
          to receiver
          subject "Welcome to wherewoof" 
          text_part do
            body "Wherewoof is forwarding a message from " + name +  ".The message is " + message + " Track " + receiver + " at " + url + "!"
          end
        end
        return
      end
      session[:receiver].each do |messenger|
        receiver = messenger
        gmail.deliver do
          to messenger
          subject "Welcome to wherewoof " + message
          text_part do
            body "Wherewoof is forwarding a message from " + name +  ".The message is " + message + " Track " + receiver + " at " + url + "!"
          end
        end
      end
    end
  end
  
  def tracking
    #@sess = session[:latlong]
    #logger.debug "sess = #{session[:latlong]}"
    id = params[:id]
    if Event.exists?(id: id)
      @event = Event.find(id)
      if @event.active == true
        @lati = @event.current_lat
        @longi = @event.current_lng
        
        return {lat: @lati, lng: @longi}
        logger.debug "lat = #{@lati}"
        logger.debug "lng = #{@longi}"
    #logger.debug "lati = #{@lati}"
    #@longi = $longitud
    #logger.debug "longi = #{@longi}"
      end
    end
  end
  
  def latlng
    id = params[:id]
    if Event.exists?(id: id)
      @event = Event.find(id)
      # if @event.active == true
      @lati = @event.current_lat
      @longi = @event.current_lng
    
      logger.debug "lat = #{@lati}"
      logger.debug "lng = #{@longi}"
      @data = {:lat => @lati, :lng => @longi}
      render json: @data
      # end
    end
  end

  def store_event
    if params[:eid]
      @eid = params[:eid]
      @event = Event.where(id: @eid.to_i).first
      logger.debug "event: #{@event.inspect}"
      session[:receiver_name] = @event[:receiver_name]
      session[:receiver] = @event[:receiver]
      session[:address_string] = @event[:address_string]
      session[:duration_setting] = @event[:duration_setting]
      session[:message] = @event[:message]
      # # @datetime_sent = @event[:datetime_sent]

      # # session[:receiver_name] = @receiver_name
      # session[:info] = @receiver
      # session[:formatted_address] = @formatted_address
      # session[:duration] = @duration_setting
      # # session[:datetime_sent] = @datetime_sent
      # session[:message] = ""

      logger.debug "session[:info]: #{session[:info]}"
      logger.debug "session[:formatted_address]: #{session[:formatted_address]}"
      logger.debug "session[:duration]: #{session[:duration]}"
      redirect_to event_summary_path
      # render text: "<script>window.location = '#{event_summary_path}';</script>", status: 200
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
        #:current_lat => session[:current_lat],
        #:current_lng => session[:current_lng]
      )
      
    session['url'] = "http://wherewoof.herokuapp.com/event/tracking/" + @event.id.to_s
    send_mail
    redirect_to controller: 'event', action: 'user_map', id: @event.id
  end

end
