Feature: Message templates to choose from

    As a user, 
    so that I can send messages quickly, 
    I want some message templates to choose from

Scenario: I want to send a message from my templates
    Given I am on the message page
    And I press "Message"
    And I press "Next"
    Then I should be on the summary page
    And I should see "Message"
