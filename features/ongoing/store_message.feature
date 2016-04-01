Feature: Writing a message

    As a user
    So as to tell my friends about the details of the event
    I want to write a message to them
    
Scenario: Successfully writing a message
    
    Given I am on the message page
    When I fill in "message_field" with "Message"
    And I follow "Next"
    Then I should be on the summary page
    And I should see "Message"
    
    