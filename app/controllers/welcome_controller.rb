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
end
