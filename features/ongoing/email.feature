Feature: Emailing function

    As a user of the wherewoof app
    I should be able to use the wherewoof event page
    so I can send a notifying email to all contacts selected.

Background:
    As a user of the wherewoof app
    To easily share my location to my contacts
    I want an easily accessible "New Event" button on the homescreen
    
    Given I log in
    Then I should be on the welcome page
    When I follow "New"
    Then I should be on the select destination page
        
    Given I am on the select destination page
    When I follow "Next"
    Then I should be on the select contacts page
    


@wip
Scenario: I send an email and the contact was submitted
    Given I am on the select contacts page
    And I fill in "email" with "user@berkeley.edu"
    And I press "Submit"
    Then I should be on the select contacts page
    Then I should see "user@berkeley.edu"
    And I should see "user created"
    When I check the following emails: user_berkeley.edu
    And I press "Submit Contacts"
    Given I am on the select duration page
    When I follow "Next"
    Then I should be on the message page
    Given I am on the message page
    When I follow "Next"
    Then I should be on the summary page
    When I press the send button
    Then I should see "message sent"

@wip
Scenario: Email fails with no contacts
    Given I am on the summary page
    When I press the send button,
    Then I should see "No contacts were selected."