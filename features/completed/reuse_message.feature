Feature: Message templates to choose from

    As a user, 
    so that I can send messages quickly, 
    I want to be able to select messages that I have used before from the template messages
    
Background:
  Given the following events exist:
	| address_string                             | receiver_name | receiver     | message | datetime_sent | duration_setting | active |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | "On my way!" | 2016-03-21 00:00:10 UTC | '1 hour' | false |
    Given I am on the message page
    
Scenario: I want to reuse a message used previously
 
    Then I should see "On my way!"
    And I press "On my way!"
    And I press "Next"
    Then I should be on the summary page
    And I should see "Message"