# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'

    when /^the history page$/
      '/welcome/history'
      
    when /^the login page$/
      '/welcome/login'
   
    when /^the new user page$/
      '/welcome/new_user'
      
    when /^the welcome page$/
      '/welcome/index'
      
    when /^the select contacts page$/
      '/event/select_contacts'
    
    when /^the select duration page$/
      '/event/select_duration'  

    when /^the message page$/
      '/event/message'  

    when /^the summary page$/
      '/event/summary'  

    when /^the confirm page$/
      '/event/confirm'
      
    when /^the gmail page$/
      '/contacts/gmail/callback'
      
    when /^the select destination page$/
      '/event/select_destination'
      
    when /^a saved destination$/
      '/event/select_contacts'
      
    when /^the duration page/
      '/event/select_duration'
      
    when /^the message page/ 
      '/event/message'
      
    when /^the user's live tracking page/
      '/event/live_tracking'
      
    when /^the receiver's live tracking page/
      '/event/tracking'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
