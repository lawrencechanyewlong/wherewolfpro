Feature: select duration for a new event
  
    As a user
    So that I can easily set a duration for my event
    I want to use a slider to set my duration
    
Background: 
  
    Given I am on the duration page


Scenario: Until I arrive should be checked at the start
    
    Then I should see "Until I Arrive"
    Then the "arrive" checkbox should be checked

Scenario: PENDING: Choosing until I arrive as duration
  
    When I move the slider for "Until This Time" to "12"
    And I check the checkbox "am"
    Then the checkbox for "Until I Arrive" should be unchecked
    And the slider for "For this many hours" should be at "0"
    And a mouseover should appear over the "Until this time" slider
    And the mouseover should indicate "12 noon" or "12 midnight"

Scenario: PENDING: Choosing for this many hours as duration
    
    When I move the slider for "For this many hours" to "10"
    Then the checkbox for "Until I Arrive" should be unchecked
    And the slider for "Until This Time" should be at "0"
    And a mouseover should appear over the "For this many hours" slider
    And I should see "Current value: 10"
    
  
    
    
    
    
    
    