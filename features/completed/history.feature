Feature:
	As a user, 
	I want the shortcuts tab to take me to my recent events history, 
	so that I can select a previously entered event at the top easily.

Background:
	Given the following events exist:
	| id | address_string                             | receiver_name | receiver     | datetime_sent           | duration_setting | active |
	| 1   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:10 UTC | '1 hour'         | false  |
	| 2   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:09 UTC | '1 hour'         | false  |
	| 3   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:08 UTC | '1 hour'         | false  |
	| 4   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:07 UTC | '1 hour'         | false  |
	| 5   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:06 UTC | '1 hour'         | false  |
	| 6   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:05 UTC | '1 hour'         | false  |
	| 7   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:04 UTC | '1 hour'         | false  |
	| 8   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:03 UTC | '1 hour'         | false  |
	| 9   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:02 UTC | '1 hour'         | false  |
	| 10  | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:01 UTC | '1 hour'         | false  |
	| 11  | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | '5107100734' | 2016-03-21 00:00:00 UTC | '1 hour'         | false  |


Scenario: Navigate to the history page
	Given I am on the home page
	And I follow "History"
	Then I am on the history page


Scenario: The 10 most recent events are shown
	Given I am on the history page
	Then I should see event 1 to 10
	And I should not see event 11


Scenario: The most recent event appears at the top of the list
	Given I am on the history page
	And I should see event 1 to 10
	Then I should see events sorted by recency	


Scenario: Click on a past event
	Given I am on the history page
	And I should see event 1
	And I press event 1
	Then I should be on the summary page
  
