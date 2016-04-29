Feature: Create the event after all the selections
  
  As a user
  so that I can share my location with my friends
  I want to create a link to my event
  
Background:
  Given the following events exist:
	| address_string                             | receiver_name | receiver     | datetime_sent           | duration_setting | active |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:10 UTC | '1 hour'         | true   |

Scenario: Create Link-id
  
  Given I am on the sender's map page
  Then there should be a link-id