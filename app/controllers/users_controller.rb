class UsersController < ApplicationController
  def third_party
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
    user = User.new :email => email, :password => "gibberjabber"
    contact_list = []
    session[:id] = user.id
    contacts.each do |contact|
      if contact[:email].length > 0
        contact_list += ["#{contact[:email]}"]
      end
    end
    user.contacts = contact_list
    user.save!
    redirect_to "/welcome/index"
  end
  
  def login
    some_user = params['user']
    email = some_user['email']
    password = some_user['password']
    user = User.find_by email:email
    if user
      if password != user.password
        flash["notice"] = "wrong password"
        redirect_to "/welcome/login"
      else
        session[:id] = user.id
        redirect_to "/welcome/index"
      end
    else
      flash[:notice] = "the email is not in our database"
      redirect_to "/welcome/login"
    end
  end
  
  def new_user 
    some_user = params['user']
    email = some_user['email']
    password = some_user['password']
    user = User.find_by email: email
    if user
      flash[:notice] = "email already taken"
      redirect_to "/welcome/new_user"
      return
    end
    if email.length > 0 and password.length > 0
      user = User.new :email => email, :password => password
      user.save!
      
      flash[:notice] = "user created!"
      redirect_to "/welcome/login"
      
    else
      flash[:notice] = "entry missing"
      redirect_to "/welcome/new_user"
    end
  end
  
end