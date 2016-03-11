require 'spec_helper'

describe EventController do
    
    describe 'new' do
        it 'should go to the select contacts page' do
            should route_to(:controller => "event", :action => "select_contacts")
        end
    end
end