Feature: select duration for a new event
  
    As a user
    So that I can easily set a duration for my event
    I want to use a slider to set my duration
    
Background: 
  
    Given I am on the select duration page

Scenario: Until I arrive should be checked at the start
    
    Then I should see "Until I Arrive"
    Then the "arrive" checkbox should be checked

Scenario: Choosing until I arrive as duration
  
    When I move the slider for "slider1" to "12"
    And I choose a radio button "am"
    Then the "arrive" checkbox should not be checked
    And the slider for "slider2" should be at "0"
    And I should see "Current value: 12"

Scenario: Choosing for this many hours as duration
    
    When I move the slider for "slider2" to "10"
    Then the "arrive" checkbox should not be checked
    And the "am" checkbox should not be checked
    And the "pm" checkbox should not be checked
    And the slider for "slider1" should be at "0"
    And I should see "Current value: 10"
    
Scenario: Clicking next to go to the message page
  
    When I follow "next"
    Then I should be on the message page
    
Scenario: Clicking back to go to the contacts page
  
    When I follow "back"
    Then I should be on the select contacts page

    
    
    