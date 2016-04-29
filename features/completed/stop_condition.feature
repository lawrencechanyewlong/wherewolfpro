Feature: Stop the tracking after certain conditions
  
  As a user
  so that I can stop sharing my location with my friends
  I want the app to automatically stop tracking my location after certain conditions
  
Background:
  Given the following events exist:
	| address_string                             | receiver_name | receiver     | datetime_sent           | duration_setting | active | address_lat | address_lng        |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:10 UTC | arrive         | true   | 37.8699438  | -122.25148310000002 |
  
@wip
Scenario: Stop tracking after arriving
  
  Given I am on the sender's map page
  And my current lat is "37.8699438" and long is "-122.25148310000002"
  Then I should be on the homepage
  
Scenario: Continue tracking if not yet at destination
  
  Given I am on the sender's map page
  And my current lat is "35.8699438" and long is "-120.25148310000002"
  Then I should be on the sender's map page