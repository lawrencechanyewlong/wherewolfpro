Feature: select duration for a new event
  
    As a user
    So that I can easily set a duration for my event
    I want to use a slider to set my duration
    
Background: 
  
    Given: I am already on the duration page
  
Scenario: Choosing until I arrive as duration
    
    When I am selecting duration
    Then I should see the "Until I arrive" option to be chosen
    
Scenario: Choosing until this time as duration
  
    When I am sliding the slider for "Until this time"
    Then the the sliders for "Until I arrive" and "For this many hours" should be inactive
    And a mouseover should appear over the "Until this time" slider
    
Scenario: Choosing 12 for until this time as duration
  
    When I am sliding the slider for "Until this time" till 12
    Then the sliders for "Until I arrive" and "For this many hours" should be inactive
    And a mouseover should appear over the "Until this time" slider
    And the mouseover should indicate "12 noon" or "12 midnight"
    
Scenario: Choosing for this many hours as duration
    
    When I am sliding the slider for "For this many hours"
    Then the sliders for "Until I arrive" and "Until this time" should be inactive
    And a mouseover should appear over the "For this many hours" slider
    
  
    
    
    
    
    
    