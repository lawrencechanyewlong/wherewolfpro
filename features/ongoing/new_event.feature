Feature: Creating new event
  
    As a user of the wherewoof app
    To easily share my location to my contacts
    I want an easily accessible "New Event" button on the homescreen

  
Scenario: Creating a new event
    
    Given I am on the welcome page
    Given PENDING
    When I follow "New"
    Then I should be on the select destination page
    
Scenario: After selecting destination, see the select contacts page
        
    Given I am on the select destination page
    Given PENDING
    When I follow "Next"
    Then I should be on the select contacts page

Scenario: After selecting contacts, see the select duration page
    
    Given I am on the select contacts page
    When I follow "Next"
    Then I should be on the select duration page

Scenario: After selecting duration, see the confirm page
    
    Given I am on the select duration page
    When I follow "Next"
    Then I should be on the message page

Scenario: After wrting message, see the confirm page
    
    Given I am on the message page
    When I follow "Next"
    Then I should be on the confirm page
