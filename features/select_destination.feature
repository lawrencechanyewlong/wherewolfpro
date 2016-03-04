Feature: Send a specified destination
  
  As a user
  so that I can meet at a location with my friends
  I want to share a specific location
  
Scenario: send a location of a saved destination
  
  Given I am on destination page
  And I click on a saved destination
  Then I should be on select contact page
  
Scenario: send a location of a new destination
  
  Given I am on destination page
  And I click on map
  Then I enter "Berkeley" into the search bar
  And I press "Search_Submit"
  Then I press "Submit"
  Then I should be on select contact page