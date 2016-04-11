Feature: Message templates to choose from

    As a user, 
    so that I can send messages quickly, 
    I want some message templates to choose from

@wip
Scenario: I want to send a message from my templates
    Given I am on the message page
    And I select a message template "On my way"
    And I follow "Next"
    Then I should be on the summary page
    And I should see "On my way"
