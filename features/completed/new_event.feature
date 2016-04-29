Feature: Creating new event
  
    As a user of the wherewoof app
    To easily share my location to my contacts
    I want an easily accessible "New Event" button on the homescreen

  
Scenario: Creating a new event
    
    Given I log in
    Then I should be on the welcome page
    When I follow "New"
    Then I should be on the select destination page
    
Scenario: After selecting destination, see the select contacts page
        
    Given I am on the select destination page
    When I follow "Next"
    Then I should be on the select contacts page

Scenario: After selecting contacts, see the select duration page
    
    Given I am on the select contacts page
    And I fill in "name" with "user"
    And I fill in "email" with "user@berkeley.edu"
    And I press "Add New Contact"
    Then I should be on the select contacts page
    And I should see "user@berkeley.edu"
    And I should see "user created"
    When I check the following emails: user@berkeley.edu
    And I press "Next"
    Then I should be on the select duration page

Scenario: After selecting duration, see the confirm page
    
    Given I am on the select duration page
    When I follow "Next"
    Then I should be on the message page

Scenario: After wrting message, see the confirm page
    
    Given I am on the message page
    When I press "Next"
    Then I should be on the summary page
