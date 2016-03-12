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
  
  def contact
    contacts = request.env['omnicontacts.contacts']
    contact_list = []
    contacts.each do |contact|
      contact_list += ["#{contact[:email]}"]
    end
    redirect_to event_select_contacts_path(:contacts => ["google.com"]), :action => "post"
    
  end
end
