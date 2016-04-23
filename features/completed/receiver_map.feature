Feature: Live location tracking for map
    
    As a viewer
    So as to easily track the location of the event creator
    I want to see the event creator's location on a map
    
Background:
  Given the following events exist:
	| id | address_string                             | receiver_name | receiver     | datetime_sent           | duration_setting | active |
	| 1   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:10 UTC | '1 hour'         | true  |
    Given I am on the receiver's live tracking page

Scenario: Seeing the map rendered
  
    Then I should see "Sender's Location"
    Then I should see the map rendered