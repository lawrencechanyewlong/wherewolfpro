require 'spec_helper'

describe EventController, :type => :controller do
    
    describe 'new' do
        it 'should go to the select contacts page' do
            # should route_to(:controller => "event", :action => "select_destination")
        end
    end
    describe 'new' do
        it 'should send an email' do
            get(:send_mail, {'id' => "12"}, {:url => "http://wherewolf.heroku.com", :message => "cake", :receiver => "asdf@berkeley.edu"})
        end
    end
end