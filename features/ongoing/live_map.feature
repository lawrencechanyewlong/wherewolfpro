Feature: Live location tracking for map
    
    As a user
    So as to easily track and know the location of the creator of the event
    I want a real time update on the google map of the creator
    
Background:
  
    Given I am I have followed the link sent to me by the creator of the event

@wip    
Scenario: Seeing the map rendered
  
    Then I should be on the map page
    And I should see the map rendered
    And the location of creator of the event on the map as a pin
    
@wip
Scenario: Live tracking of the location
    
    When that the location of the creator has changed
    Then I should see that the location of the pin has moved

@wip    
Scenario: Opening the link when the time has expired
  
    Then I should be on the error page
    And I should see "Sorry the event has ended"
 