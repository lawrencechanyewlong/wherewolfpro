Feature: Message templates to choose from

    As a user, 
    so that I can send messages quickly, 
    I want to be able to select messages that I have used before from the template messages
    
Background:
  Given the following events exist:
	| id | address_string                             | receiver_name | receiver     | message | datetime_sent | duration_setting | active |
	| 1   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | "Message" | 2016-03-21 00:00:10 UTC | '1 hour' | false |
    Given I am on the message page
    
@wip
Scenario: I want to reuse a message used previously
 
    Then I should see "Message" as one of the template message
    And I press "Message"
    Then I should be on the summary page
    And I should see "Message"