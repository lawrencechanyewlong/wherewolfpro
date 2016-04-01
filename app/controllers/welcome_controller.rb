class WelcomeController < ApplicationController
  def index
    if session[:id]
      user = User.find(session[:id])
      @name = user.name
    else
      redirect_to "/welcome/login"
    end 
  end
  
  
  def destroy
    session[:id] = nil
    
    redirect_to "/"
  end
  
  def history
    @history = []
    i = 0
    Event.all.each do |e|
      @history << e
    end
    @history.sort!{ |x,y| y[:datetime_sent] <=> x[:datetime_sent] }
    @history = @history.first(10)
  end

  def store_event
    if params[:eid]
      @eid = params[:eid]
      @event = Event.where(eid: @eid).first
      @receiver_name = @event[:receiver_name]
      @receiver = @event[:receiver]
      @formatted_address = @event[:address_string]
      @duration_setting = @event[:duration_setting]
      @datetime_sent = @event[:datetime_sent]

      session[:receiver_name] = @receiver_name
      session[:receiver] = @receiver
      session[:formatted_address] = @formatted_address
      session[:duration_setting] = @duration_setting
      session[:datetime_sent] = @datetime_sent
      
      render text: "<script>window.location = '#{event_summary_path}';</script>", status: 500
    end

  end
end
