class WelcomeController < ApplicationController
  def index
    if session[:id]
      user = User.find_by id: session[:id]
      if !user
        session[:id] = nil
        return
      end
      @name = user.name
    else
      @name = nil
    end

  end
  
  def clear_event
    session.delete(:address_string)
    session.delete(:address_lat)
    session.delete(:address_lng)
    session.delete(:receiver)
    session.delete(:receiver_name)
    session.delete(:receiver_all)
    session.delete(:receiver_name_all)
    session.delete(:duration_setting)
    session.delete(:message)
    redirect_to "/"
  end
  
  def destroy
    session[:id] = nil
    
    redirect_to "/"
  end
  
  def history
    @history = []
    i = 0
    Event.all.each do |e|
      puts e.inspect
      @history << e
    end
    @history.sort!{ |x,y| y[:datetime_sent] <=> x[:datetime_sent] }
    @history = @history.first(10)
  end

  # def store_event
  #   if params[:eid]
  #     @eid = params[:eid]
  #     @event = Event.where(eid: @eid.to_i).first
  #     logger.debug "event: #{@event.inspect}"
  #     @receiver_name = @event[:receiver_name]
  #     @receiver = @event[:receiver]
  #     @formatted_address = @event[:address_string]
  #     @duration_setting = @event[:duration_setting]
  #     @datetime_sent = @event[:datetime_sent]

  #     # session[:receiver_name] = @receiver_name
  #     session[:info] = @receiver
  #     session[:formatted_address] = @formatted_address
  #     session[:duration] = [@duration_setting]
  #     # session[:datetime_sent] = @datetime_sent

  #     logger.debug "session[:info]: #{session[:info]}"
  #     logger.debug "session[:formatted_address]: #{session[:formatted_address]}"
  #     logger.debug "session[:duration]: #{session[:duration]}"
      
  #     render text: "<script>window.location = '#{event_summary_path}';</script>", status: 200
  #   end

  # end
end
