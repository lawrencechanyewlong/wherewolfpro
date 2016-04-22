Feature: Stop the tracking after certain conditions
  
  As a user
  so that I can stop sharing my location with my friends
  I want the app to automatically stop tracking my location after certain conditions
  
Background:
  Given the following events exist:
	| id | address_string                             | receiver_name | receiver     | datetime_sent           | duration_setting | active |
	| 1   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:10 UTC | '1 hour'         | true  |
  Given I am on the user's live tracking page
  
Scenario: PENDING: Stop tracking after one hour
  
  And it has been one hour
  Then I should be on the homepage