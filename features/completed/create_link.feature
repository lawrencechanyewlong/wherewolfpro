Feature: Create the event after all the selections
  
  As a user
  so that I can share my location with my friends
  I want to create a link to my event
  
Background:
  Given the following events exist:
	| id | address_string                             | receiver_name | receiver     | datetime_sent           | duration_setting | active |
	| 1   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:10 UTC | '1 hour'         | true  |
  Given I am on the user's live tracking page
  
  
Scenario: Create Link-id
  
  Then I should see "Link-id"