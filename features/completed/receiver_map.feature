Feature: Live location tracking for map
    
    As a viewer
    So as to easily track the location of the event creator
    I want to see the event creator's location on a map
    
Background:
    Given I am on the receiver's live tracking page

Scenario: Seeing the map rendered
  
    Then I should see "Receiver's view"
    Then I should see the map rendered