class UsersController < ApplicationController
  def index
    
    contacts = request.env['omnicontacts.contacts']
    user_data = request.env['omnicontacts.user']
    name = user_data[:name]
    email = user_data[:email]
    user = User.find_by email: user_data[:email]
    if user
      @contacts = user.contacts
      session[:id] = user.id
      redirect_to "/welcome/index"
      return
    end
    user = User.new :name => name, :email => email
    contact_list = []
    session[:id] = user.id
    contacts.each do |contact|
      contact_list += ["#{contact[:email]}"]
    end
    user.contacts = contact_list
    user.save!
    
    redirect_to "/welcome/index"
  end
end
