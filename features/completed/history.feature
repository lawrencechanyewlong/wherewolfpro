Feature:
	As a user, 
	I want the shortcuts tab to take me to my recent events history, 
	so that I can select a previously entered event at the top easily.

Background:
	Given the following events exist:
	| id    | address_string                             | receiver_name | receiver  | duration_setting | active |
	| 101   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
	| 102   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
	| 103   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
	| 104   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
	| 105   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
	| 106   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
	| 107   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
	| 108   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
	| 109   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
	| 110   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |
	| 111   | '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Melvyn'      | 'a@a.com' | '1 hour'         | false  |


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
  
