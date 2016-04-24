Feature: Live location tracking for map
    
    As a user
    So that I can send my location
    I want a map with real time update of my location
    
Background:
  Given the following events exist:
	| id    | address_string                             | receiver_name | receiver  | duration_setting | active |
    | 101   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
    Given I am on the user's live tracking page
    
Scenario: Seeing the map rendered
  
    Then I should see "Sender Location"
    Then I should see the map rendered

    
#Scenario: Live tracking of the location
    
    #When the location of the creator has changed
    #Then I should see that the location of the pin has moved
    
    
#Scenario: Opening the link when the time has expired
  
    #Then I should be on the error page
    #And I should see "Sorry the event has ended"
