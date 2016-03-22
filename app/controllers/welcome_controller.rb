class WelcomeController < ApplicationController
  def index
    if session[:id]
      user = User.find(session[:id])
      @name = user.name
    end 
  end
  
  def create
    auth_hash = request.env['omniauth.auth']
   # auth_hash.to_yaml =~ /email:(.*)/
    email = auth_hash['info']['email']
    #auth_hash.to_yaml =~ /name:(.*)/
    name =  auth_hash['info']['name']
    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      session[:id] = @authorization.id
    else
      user = User.new :name => name, :email => email
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save
      session[:id] = user.id
    end
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
      @history << e
      i += 1
      if i == 10 then break end
    end
    @history.sort!{ |x,y| y[:datetime_sent] <=> x[:datetime_sent] }
  end
end
