Feature:
	As a user, 
	I want the shortcuts tab to take me to my recent events history, 
	so that I can select a previously entered event at the top easily.

Background:
	Given the following events exist:
	| address_string                             | receiver_name | receiver  | duration_setting | active |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person101'      | 'a@a.com' | '1 hour'         | false  |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person102'      | 'a@a.com' | '1 hour'         | false  |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person103'      | 'a@a.com' | '1 hour'         | false  |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person104'      | 'a@a.com' | '1 hour'         | false  |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person105'      | 'a@a.com' | '1 hour'         | false  |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person106'      | 'a@a.com' | '1 hour'         | false  |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person107'      | 'a@a.com' | '1 hour'         | false  |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person108'      | 'a@a.com' | '1 hour'         | false  |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person109'      | 'a@a.com' | '1 hour'         | false  |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person110'      | 'a@a.com' | '1 hour'         | false  |
	| '2299 Piedmont Avenue, Berkeley, CA 94720' | 'Person111'      | 'a@a.com' | '1 hour'         | false  |


Scenario: Navigate to the history page
	Given I am on the home page
	And I follow "History"
	Then I am on the history page


Scenario: The 10 most recent events are shown
	Given I am on the history page
	Then I should see person 102 to 111
	And I should not see person 101


Scenario: The most recent event appears at the top of the list
	Given I am on the history page
	And I should see person 102 to 111
	Then I should see events sorted by recency	


Scenario: Click on a past event
	Given I am on the history page
	And I should see person 102
	And I press "Person102"
	Then I should be on the summary page
  
